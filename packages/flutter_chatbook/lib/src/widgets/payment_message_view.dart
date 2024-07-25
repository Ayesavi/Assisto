part of '../../flutter_chatbook.dart';

class PaymentMessageView extends StatefulWidget {
  final PaymentMessage message;
  final ChatBubble? incomingBubbleConfig;
  final ChatBubble? outgoingBubbleConfig;

  const PaymentMessageView(
    this.message, {
    super.key,
    this.incomingBubbleConfig,
    this.outgoingBubbleConfig,
  });

  @override
  State<PaymentMessageView> createState() => _PaymentMessageViewState();
}

class _PaymentMessageViewState extends State<PaymentMessageView> {
  late final String remoteUserName;
  late final String currentUserId;
  TextStyle? senderNameTextStyle;
  TextStyle? amountTextStyle;
  TextStyle? statusTextStyle;
  TextStyle? buttonTextStyle;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (provide != null) {
      remoteUserName = provide!.recipientName;
      currentUserId = provide!.currentUserId;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isRequest = widget.message.paymentType == PaymentType.request;
    final isPaymentByYou = widget.message.authorId == currentUserId;
    final config = widget.message.authorId == currentUserId
        ? widget.outgoingBubbleConfig
        : widget.incomingBubbleConfig;
    senderNameTextStyle = config?.paymentConfig?.senderNameTextStyle ??
        Theme.of(context).textTheme.titleLarge;
    amountTextStyle = config?.paymentConfig?.paymentAmountTextStyle ??
        Theme.of(context).textTheme.titleLarge;
    statusTextStyle = config?.paymentConfig?.paymentStatusTextStyle ??
        Theme.of(context).textTheme.labelSmall;
    buttonTextStyle = config?.paymentConfig?.requestButtonTextStyle ??
        Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              isPaymentByYou
                  ? '${isRequest ? 'Request' : 'Payment'} to ${remoteUserName}'
                  : '${isRequest ? 'Request' : 'Payment'} to you',
              style: senderNameTextStyle),
          SizedBox(height: 4),
          Text('$kRupeeSymbol ${widget.message.amount.toString()}',
              style: amountTextStyle),
          SizedBox(height: 4),
          if (!isRequest)
            _getPaymentStatusWidget(widget.message.paymentStatus)
          else
            _getRequestStatusWidget(widget.message.paymentStatus),
          if (isRequest &&
              !isPaymentByYou &&
              widget.message.paymentStatus == PaymentStatus.pending)
            _getRequestButtons(),
        ],
      ),
    );
  }

  Widget _getRequestButtons() {
    return SizedBox(
      height: 80,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          OutlinedButton(
              onPressed: () {},
              child: Text(
                "Decline",
                style: buttonTextStyle,
              )),
          SizedBox(width: 4),
          OutlinedButton(
              onPressed: () {}, child: Text("Pay", style: buttonTextStyle)),
        ],
      ),
    );
  }

  Widget _getPaymentStatusWidget(PaymentStatus status) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        _getStatusIcon(status),
        SizedBox(width: 4),
        Text(
          _getStatusText(status),
          style: statusTextStyle,
        ),
        Text(
          ' • ' +
              DateFormat('dd MMM yyyy', 'en_US')
                  .format(widget.message.createdAt.toLocal()),
          style: statusTextStyle,
        ),
      ],
    );
  }

  Widget _getRequestStatusWidget(PaymentStatus status) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        _getStatusIcon(status),
        SizedBox(width: 4),
        Text(
          '${_getRequestStatusText(status)}',
          style: statusTextStyle,
        ),
        Text(
          ' • ' +
              DateFormat('dd MMM yyyy', 'en_US')
                  .format(widget.message.createdAt.toLocal()),
          style: statusTextStyle,
        ),
      ],
    );
  }

  Widget _getStatusIcon(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.failed:
        return Icon(
          Icons.close_outlined,
          color: Theme.of(context).colorScheme.error,
        );
      case PaymentStatus.success:
        return Icon(Icons.check_circle, color: Colors.green);
      case PaymentStatus.pending:
        return Icon(
          Icons.schedule,
        );
    }
  }

  String _getStatusText(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.success:
        return 'Paid';
      case PaymentStatus.failed:
        return 'Failed';
      case PaymentStatus.pending:
        return 'Pending';
    }
  }

  String _getRequestStatusText(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.success:
        return 'Paid';
      case PaymentStatus.failed:
        return 'Failed';
      case PaymentStatus.pending:
        return 'Unpaid';
    }
  }
}
