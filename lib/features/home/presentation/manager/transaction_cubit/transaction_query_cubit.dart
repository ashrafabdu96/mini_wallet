import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_wallet/features/home/domain/entities/transaction_entity.dart';
import 'package:mini_wallet/features/home/domain/use_cases/transactions_query_usecase.dart';

part 'transaction_query_state.dart';

class TransactionQueryCubit extends Cubit<TransactionQueryState> {
  TransactionQueryCubit({required this.transactionsQueryUsecase})
      : super(const TransactionQueryInitial());

  final TransactionsQueryUsecase transactionsQueryUsecase;
  getTransactionQuery(
      {required TransactionsQueryParameters
          transactionsQueryParameters}) async {
    final result =
        await transactionsQueryUsecase(params: transactionsQueryParameters);
    result.fold(
      (l) => emit(TransactionQueryFailure(l.failureMessage)),
      (r) => emit(
        TransactionQuerySuccessState(
          transactionsQuery: r,
        ),
      ),
    );
  }
}
