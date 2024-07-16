import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_req_model.freezed.dart';
part 'payment_req_model.g.dart';

@freezed
class PaymentReqModel with _$PaymentReqModel {
  factory PaymentReqModel({
    @JsonKey(name: "payment_session_id") required String sessionId,
    @JsonKey(name: "cf_order_id") required String orderId,
    @JsonKey(name: "order_amount") required double amount,
  }) = _PaymentReqModel;

  factory PaymentReqModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentReqModelFromJson(json);
}
