part of 'transaction_query_cubit.dart';

abstract class TransactionQueryState extends Equatable {
  const TransactionQueryState();
  @override
  List<Object> get props => [];
}

class TransactionQueryInitial extends TransactionQueryState {
  const TransactionQueryInitial();
  @override
  List<Object> get props => [];
}

class TransactionQuerySuccessState extends TransactionQueryState {
  final List<TransactionEntity> transactionsQuery;
  const TransactionQuerySuccessState({required this.transactionsQuery});
  @override
  List<Object> get props => [
        transactionsQuery,
      ];
}

class TransactionQueryLoading extends TransactionQueryState {
  const TransactionQueryLoading();
  @override
  List<Object> get props => [];
}

class TransactionQueryFailure extends TransactionQueryState {
  const TransactionQueryFailure(this.message);
  final String message;
  @override
  List<Object> get props => [];
}
