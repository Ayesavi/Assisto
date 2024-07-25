import 'package:assisto/core/analytics/analytics_events.dart';
import 'package:assisto/core/analytics/app_analytics.dart';
import 'package:assisto/core/controllers/auth_controller/auth_controller.dart';
import 'package:assisto/core/extensions/string_extension.dart';
import 'package:assisto/features/chat/controllers/chat_page_controller.dart';
import 'package:assisto/features/chat/screens/chat_profile.dart';
import 'package:assisto/gen/assets.gen.dart';
import 'package:assisto/models/user_model/user_model.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:assisto/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatbook/flutter_chatbook.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatPage extends ConsumerStatefulWidget {
  final int roomId;
  const ChatPage({super.key, required this.roomId});

  static int? activeRoom;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage>
    with WidgetsBindingObserver {
  late ChatController controller;
  late final ChatPageControllerProvider provider;
  final FocusNode _focusNode = FocusNode();
  final analytics = AppAnalytics.instance;
  final analyticsEvents = AnalyticsEvent.taskChat;
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    ChatPage.activeRoom = widget.roomId;
    super.initState();
    provider = chatPageControllerProvider(widget.roomId);
    controller = ChatController(
        focusNode: _focusNode,
        initialMessageList: [],
        paginationCallback: () async {
          return await ref.read(provider.notifier).loadChats();
        },
        currentUserId:
            ref.read(authControllerProvider.notifier).user?.id ?? '');
    ref.read(provider.notifier).addMessageListener(widget.roomId, onMessage);
    ref.listenManual(provider, (prev, next) {
      if (next.isData) {
        controller.loadMoreData((next as ChatPageData).messages);
      }
    }, fireImmediately: true);
  }

  onMessage(Message message) {
    if (ref.context.mounted &&
        message.authorId !=
            ref.read(authControllerProvider.notifier).user?.id) {
      controller.addMessage(message);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
        onBackground();
        break;
      default:
        onBackground();
        break;
    }
  }

  void onBackground() {
    if (ref.context.mounted) {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    Supabase.instance.client.removeAllChannels();
    ChatPage.activeRoom = null;
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
      automaticallyImplyLeading: false,
      actions: [
        Builder(
          builder: (context) {
            final phoneNumber = ref.watch(chatUserPhoneNumberProvider(
                (taskId: widget.roomId, userId: model.id)));
            return phoneNumber.when(
              data: (phone) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      onPressed: () async {
                        final Uri launchUri = Uri(
                          scheme: 'tel',
                          path: phone,
                        );
                        await launchUrl(launchUri);
                      },
                      icon: const Icon(Icons.phone)),
                );
              },
              error: (error, stackTrace) {
                return const SizedBox.shrink();
              },
              loading: () {
                return const SizedBox.shrink();
              },
            );
          },
        )
      ],
      title: GestureDetector(
        onTap: () {
          analytics.logEvent(name: analyticsEvents.chatAppBarPressEvent);

          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return ChatProfile(
                userModel: model,
                taskId: widget.roomId,
              );
            },
          ));
        },
        child: Row(
          children: [
            const BackButton(),
            UserAvatar(
              imageUrl: model.avatarUrl,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name.capitalize,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatBook(UserModel model, List<Message> messages,
      {required String remoteUserName}) {
    final scheme = Theme.of(context).colorScheme;
    final txtTheme = Theme.of(context).textTheme;

    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage(Assets.images.chatLight.path),
            fit: BoxFit.fill,
            alignment: Alignment.topCenter,
          ),
        ),
        child: ChatBook(
            recipientName: remoteUserName,
            swipeToReplyConfig:
                SwipeToReplyConfiguration(onLeftSwipe: (message) {
              analytics.logEvent(
                  name: analyticsEvents.chatBubbleReplySwipeEvent);
            }),
            featureActiveConfig: const FeatureActiveConfig(
                enableSwipeToReply: true, enableSwipeToSeeTime: false),
            sendMessageConfig: SendMessageConfiguration(
                // onPay: () {
                //   _pushPaymentPage(context, PaymentType.payment, model);
                // },
                // onRequest: () {
                //   _pushPaymentPage(context, PaymentType.request, model);
                // },
                textFieldConfig: TextFieldConfiguration(
                    padding: const EdgeInsets.all(2),
                    borderRadius: BorderRadius.circular(16),
                    hintText: ' Send Message'),
                textFieldBackgroundColor: scheme.onInverseSurface),
            chatBubbleConfig: ChatBubbleConfiguration(
                inComingChatBubbleConfig: ChatBubble(
                    timeStampTextStyle: txtTheme.labelLarge?.copyWith(
                        color: scheme.onPrimary, fontWeight: FontWeight.w400),
                    textStyle: TextStyle(fontSize: 16, color: scheme.onPrimary),
                    paymentConfig: PaymentConfig(
                        senderNameTextStyle: txtTheme.titleMedium
                            ?.copyWith(color: scheme.onPrimary),
                        paymentAmountTextStyle: txtTheme.titleLarge
                            ?.copyWith(color: scheme.onPrimary),
                        paymentStatusTextStyle: txtTheme.labelSmall
                            ?.copyWith(color: scheme.onPrimary)),
                    color: scheme.primary),
                outgoingChatBubbleConfig: ChatBubble(
                    timeStampTextStyle: txtTheme.labelLarge
                        ?.copyWith(fontWeight: FontWeight.w400),
                    paymentConfig: PaymentConfig(
                        senderNameTextStyle: txtTheme.titleMedium
                            ?.copyWith(color: scheme.onSurface),
                        paymentAmountTextStyle: txtTheme.titleLarge
                            ?.copyWith(color: scheme.onSurface)),
                    color: scheme.onInverseSurface,
                    textStyle:
                        TextStyle(fontSize: 16, color: scheme.onSurface))),
            chatController: controller,
            onSendTap: (m) async {
              controller.addMessage(m.copyWith(
                  authorId:
                      ref.read(authControllerProvider.notifier).user?.id));
              ref.read(provider.notifier).addMessage(m);
            },
            currentUserId:
                ref.read(authControllerProvider.notifier).user?.id ?? '',
            roomId: widget.roomId,
            repliedMessageConfig: const RepliedMessageConfiguration(),
            chatBookState: ChatBookState.hasMessages));
  }
}
