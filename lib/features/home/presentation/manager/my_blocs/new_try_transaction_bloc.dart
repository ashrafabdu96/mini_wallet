import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_wallet/features/home/domain/entities/transaction_entity.dart';
import 'package:mini_wallet/features/home/domain/use_cases/transactions_query_usecase.dart';
import 'package:mini_wallet/features/home/domain/use_cases/try_get_all_transactions_usecase.dart';

part 'new_try_transaction_event.dart';
part 'new_try_transaction_state.dart';

class NewTryTransactionBloc
    extends Bloc<NewTryTransactionEvent, NewTryTransactionState> {
  final TryGetAllTransactionsUsecase tryGetAllTransactionsUsecase;
  // final TransactionsQueryUsecase transactionsQueryUsecase;
  NewTryTransactionBloc(
      {
      // required this.transactionsQueryUsecase,
      required this.tryGetAllTransactionsUsecase})
      : super(TransactionLoadInProgress()) {
    on((event, emit) async {
      if (event is GetAllTransactionsEvent) {
        await Future.delayed(const Duration(seconds: 2));
        final failureOrSuccessResult =
            await tryGetAllTransactionsUsecase(params: const NoParameters());
        emit(
          failureOrSuccessResult.fold(
            (l) => TransactionLoadFailure(message: l.failureMessage),
            (r) => TransactionLoadSuccess(transactions: r),
          ),
        );
      }
    });
  }

  @override
  Future<void> close() {
    close();
    return super.close();
  }
}
