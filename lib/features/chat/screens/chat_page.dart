import 'package:assisto/core/analytics/analytics_events.dart';
import 'package:assisto/core/analytics/app_analytics.dart';
import 'package:assisto/core/controllers/auth_controller/auth_controller.dart';
import 'package:assisto/features/chat/controllers/chat_page_controller.dart';
import 'package:assisto/features/chat/screens/chat_profile.dart';
import 'package:assisto/features/chat/screens/payment_page.dart';
import 'package:assisto/models/user_model/user_model.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:assisto/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatbook/flutter_chatbook.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatPage extends ConsumerStatefulWidget {
  final int roomId;
  const ChatPage({super.key, required this.roomId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  late ChatController controller;
  late final ChatPageControllerProvider provider;

  final analytics = AppAnalytics.instance;
  final analyticsEvents = AnalyticsEvent.taskChat;
  @override
  void initState() {
    super.initState();
    provider = chatPageControllerProvider(widget.roomId);
    ref.listenManual(provider, (prev, next) {
      if (next.isData) {
        controller = ChatController(
            initialMessageList: [...(next as ChatPageData).messages],
            currentUserId:
                ref.read(authControllerProvider.notifier).user?.id ?? '');
      }
    });
    ref.read(provider.notifier).addMessageListener(widget.roomId, onMessage);
  }

  onMessage(Message message) {
    if (message.authorId !=
        ref.read(authControllerProvider.notifier).user?.id) {
      controller.addMessage(message);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(provider);
    return state.when(loading: () {
      return _buildScaffold(
          body: const Center(
        child: CircularProgressIndicator(),
      ));
    }, data: (userModel, messages) {
      return _buildScaffold(
          appBar: _buildAppBar(context, userModel),
          body: _buildChatBook(userModel, messages,
              remoteUserName: userModel.name));
    }, error: (e) {
      return _buildScaffold(
          body: Center(
        child: BodyLarge(
          text: e.message,
          color: Theme.of(context).colorScheme.error,
        ),
      ));
    }, networkError: () {
      return _buildScaffold(
          body: Center(
        child: BodyLarge(
          text: 'Looks like you are not connected to internet',
          color: Theme.of(context).colorScheme.error,
        ),
      ));
    });
  }

  Widget _buildScaffold({
    PreferredSizeWidget? appBar,
    required Widget body,
  }) {
    return Scaffold(
      appBar: appBar,
      body: body,
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, UserModel model) {
    return AppBar(
        leadingWidth: 30,
        // automaticallyImplyLeading: false,
        title: ListTile(
          onTap: () {
            analytics.logEvent(name: analyticsEvents.chatAppBarPressEvent);

            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return ChatProfile(userModel: model);
              },
            ));
          },
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          leading: const UserAvatar(),
          title: TitleLarge(text: model.name),
          trailing: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.phone,
                color: Theme.of(context).colorScheme.primary,
              )),
        ));
  }

  _pushPaymentPage(BuildContext context, PaymentType type, UserModel model) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return PaymentPage(
          type: type,
          userModel: model,
          onContinue: (amount, type) async {
            // write future.dealyed of 1 second
            await Future.delayed(const Duration(seconds: 1));

            /// make payment then
            final paymentMsg = PaymentMessage(
                paymentStatus: PaymentStatus.completed,
                paymentType: type,
                amount: amount,
                authorId: 'currentUserId',
                id: 'id',
                createdAt: DateTime.now(),
                roomId: widget.roomId);
            controller.addMessage(paymentMsg);
            if (context.mounted) {
              Navigator.pop(context);
            }
            return;
          },
        );
      },
    ));
  }

  Widget _buildChatBook(UserModel model, List<Message> messages,
      {required String remoteUserName}) {
    final scheme = Theme.of(context).colorScheme;
    final txtTheme = Theme.of(context).textTheme;

    return ChatBook(

        swipeToReplyConfig: SwipeToReplyConfiguration(onLeftSwipe: (message) {
          analytics.logEvent(name: analyticsEvents.chatBubbleReplySwipeEvent);
        }),

        recipientName: remoteUserName,

        featureActiveConfig: const FeatureActiveConfig(
            enableSwipeToReply: true, enableSwipeToSeeTime: false),
        sendMessageConfig: SendMessageConfiguration(
            onPay: () {
              _pushPaymentPage(context, PaymentType.payment, model);
            },
            onRequest: () {
              _pushPaymentPage(context, PaymentType.request, model);
            },
            textFieldConfig:
                const TextFieldConfiguration(hintText: ' Send Message'),
            textFieldBackgroundColor: scheme.onInverseSurface),
        chatBubbleConfig: ChatBubbleConfiguration(
            inComingChatBubbleConfig: ChatBubble(
                timeStampTextStyle:
                    txtTheme.labelSmall?.copyWith(color: scheme.onPrimary),
                textStyle: TextStyle(color: scheme.onPrimary),
                paymentConfig: PaymentConfig(
                    senderNameTextStyle:
                        txtTheme.titleMedium?.copyWith(color: scheme.onPrimary),
                    paymentAmountTextStyle:
                        txtTheme.titleLarge?.copyWith(color: scheme.onPrimary),
                    paymentStatusTextStyle:
                        txtTheme.labelSmall?.copyWith(color: scheme.onPrimary)),
                color: scheme.primary),
            outgoingChatBubbleConfig: ChatBubble(
                timeStampTextStyle: txtTheme.labelSmall,
                paymentConfig: PaymentConfig(
                    senderNameTextStyle:
                        txtTheme.titleMedium?.copyWith(color: scheme.onSurface),
                    paymentAmountTextStyle:
                        txtTheme.titleLarge?.copyWith(color: scheme.onSurface)),
                color: scheme.onInverseSurface,
                textStyle: TextStyle(color: scheme.onSurface))),
        chatController: controller,
        onSendTap: (m) async {
          controller.addMessage(m.copyWith(
              authorId: ref.read(authControllerProvider.notifier).user?.id));
          ref.read(provider.notifier).addMessage(m);
        },
        currentUserId: ref.read(authControllerProvider.notifier).user?.id ?? '',
        roomId: widget.roomId,
        repliedMessageConfig: const RepliedMessageConfiguration(),
        chatBookState: ChatBookState.hasMessages);
  }
}
