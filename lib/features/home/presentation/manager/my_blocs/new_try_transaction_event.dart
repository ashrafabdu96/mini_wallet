part of 'new_try_transaction_bloc.dart';

abstract class NewTryTransactionEvent extends Equatable {
  const NewTryTransactionEvent();
  @override
  List<Object?> get props => [];
}

class GetAllTransactionsEvent extends NewTryTransactionEvent {
  const GetAllTransactionsEvent();
  @override
  List<Object?> get props => [];
}

class GetTransactionsQueryEvent extends NewTryTransactionEvent {
  final TransactionsQueryParameters transactionsQueryParameters;
  const GetTransactionsQueryEvent({required this.transactionsQueryParameters});
  @override
  List<Object?> get props => [transactionsQueryParameters];
}
