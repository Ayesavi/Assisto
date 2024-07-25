part of 'payments_page_controller.dart';

@freezed
sealed class PaymentsPageControllerState with _$PaymentsPageControllerState {
  const PaymentsPageControllerState._();
  const factory PaymentsPageControllerState.loading() = PaymentsPageControllerLoading;
  const factory PaymentsPageControllerState.data(List<TransactionModel> models) = PaymentsPageControllerData;
  const factory PaymentsPageControllerState.error(AppException error) = PaymentsPageControllerError;
  const factory PaymentsPageControllerState.networkError() = PaymentsPageControllerNetwrorkError;
}
