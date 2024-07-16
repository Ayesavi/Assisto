import 'package:assisto/core/config/flavor_config.dart';
import 'package:assisto/core/error/handler.dart';
import 'package:assisto/models/payments/payment_req_model/payment_req_model.dart';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfwebcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';

typedef VerifyPaymentCallback = void Function(String orderId);
typedef OnErrorPaymentCallback = void Function(
    CFErrorResponse response, String orderId);

abstract class BaseAppPayments {
  void setPaymentListener(
      {required VerifyPaymentCallback verifyPaymentCallback,
      required OnErrorPaymentCallback onErrorCallback});
}

class AppPayments extends BaseAppPayments {
  // Private constructor
  AppPayments._privateConstructor();

  // Static instance
  static final AppPayments _instance = AppPayments._privateConstructor();

  final cfPaymentGatewayService = CFPaymentGatewayService();

  // Factory constructor
  factory AppPayments() {
    return _instance;
  }

  @override
  void setPaymentListener(
      {required VerifyPaymentCallback verifyPaymentCallback,
      required OnErrorPaymentCallback onErrorCallback}) {
    cfPaymentGatewayService.setCallback(verifyPaymentCallback, onErrorCallback);
  }

  CFSession _createSession(PaymentReqModel req) {
    try {
      var session = CFSessionBuilder()
          .setEnvironment(FlavorConfig().paymentEnvironment)
          .setOrderId(req.orderId)
          .setPaymentSessionId(req.sessionId)
          .build();
      return session;
    } on CFException catch (e) {
      throw AppException(e.message);
    }
  }

  checkOut(PaymentReqModel req) {
    try {
      var session = _createSession(req);
      var cfWebCheckout =
          CFWebCheckoutPaymentBuilder().setSession(session).build();
      cfPaymentGatewayService.doPayment(cfWebCheckout);
    } on CFException catch (e) {
      throw AppException(e.message);
    }
  }
}
