import 'package:assisto/core/theme/theme_constants.dart';
import 'package:assisto/models/user_model/user_model.dart';
import 'package:assisto/widgets/app_filled_button.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:assisto/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatbook/flutter_chatbook.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaymentPage extends ConsumerStatefulWidget {
  final UserModel userModel;
  final PaymentType type;
  final Future<void> Function(num amt,PaymentType type) onContinue;
  const PaymentPage(
      {super.key,
      required this.type,
      required this.userModel,
      required this.onContinue});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PaymentPageState();
}

class _PaymentPageState extends ConsumerState<PaymentPage> {
  late FocusNode _focusNode;
  num? paymentAmt;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    Future.delayed(const Duration(milliseconds: 200), () {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: kPageColumnPadding,
        child: AppFilledButton(
          label: 'Continue',
          asyncTap: () async {
            if (paymentAmt != null && paymentAmt! > 0) {
              await widget.onContinue.call(paymentAmt!,widget.type);
              return;
            }
          },
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            UserAvatar(
              imageUrl: widget.userModel.avatarUrl,
              radius: 50,
            ),
            kWidgetVerticalGap,
            TitleMedium(
              text:
                  '${widget.type == PaymentType.request ? 'Requesting from ' : "Paying to "}${widget.userModel.name}',
              maxLines: 2,
              align: TextAlign.center,
            ),
            kWidgetMinVerticalGap,
            LabelLarge(text: '${widget.userModel.phoneNumber}'),
            kWidgetVerticalGap,
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 200, minWidth: 0),
              child: TextField(
                focusNode: _focusNode,
                onChanged: (v) {
                  paymentAmt = num.tryParse(v);
                },
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '₹ 0',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
