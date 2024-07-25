import 'package:assisto/core/error/handler.dart';
import 'package:assisto/core/respositories/payments_repository/base_payments_repository.dart';
import 'package:assisto/core/respositories/payments_repository/payments_repository_provider.dart';
import 'package:assisto/models/transaction_model/transaction_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'payments_page_controller.freezed.dart';
part 'payments_page_controller.g.dart';
part 'payments_page_controller_state.dart';

@riverpod
class PaymentsPageController extends _$PaymentsPageController {
  late  BasePaymentsRepository _repo;
  final int _limit = 30;
  int _offset = 0;
  String? _recipientId;
  @override
  PaymentsPageControllerState build(String? recipientId) {
    _recipientId = recipientId;
    _repo = ref.watch(paymentsRepositoryProvider);
    loadData();
    return const PaymentsPageControllerState.loading();
  }

  void loadData({bool refresh = true}) async {
    try {
      state = const PaymentsPageControllerState.loading();
      if (refresh) {
        _offset = 0;
      }
      final data = _recipientId == null
          ? await _repo.getUserTransactions(_limit, _offset)
          : await _repo.getTransactions(_recipientId!, _limit, _offset);
      _offset += data.length;
      state = PaymentsPageControllerState.data(data);
    } catch (e) {
      if (e is NetworkException) {
        state = const PaymentsPageControllerState.networkError();
      } else {
        state = PaymentsPageControllerState.error(appErrorHandler(e));
      }
    }
  }
}
