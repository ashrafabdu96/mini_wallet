part of 'new_try_transaction_bloc.dart';

abstract class NewTryTransactionState extends Equatable {
  const NewTryTransactionState();
}

class NewTryTransactionInitial extends NewTryTransactionState {
  @override
  List<Object?> get props => [];
}

class TransactionLoadInProgress extends NewTryTransactionState {
  @override
  List<Object?> get props => [];
}

const list = [];

class TransactionLoadSuccess extends NewTryTransactionState {
  final Stream<List<TransactionEntity>> transactions;
  const TransactionLoadSuccess({
    required this.transactions,
  });

  @override
  List<Object?> get props => [transactions];

  TransactionLoadSuccess copyWith({
    Stream<List<TransactionEntity>>? transactions,
  }) {
    return TransactionLoadSuccess(
      transactions: transactions ?? this.transactions,
    );
  }
}

class TransactionQueryLoadSuccess extends NewTryTransactionState {
  final List<TransactionEntity> transactions;
  const TransactionQueryLoadSuccess({
    required this.transactions,
  });

  @override
  List<Object?> get props => [transactions];

  TransactionQueryLoadSuccess copyWith({
    List<TransactionEntity>? transactions,
  }) {
    return TransactionQueryLoadSuccess(
      transactions: transactions ?? this.transactions,
    );
  }
}

class TransactionLoadFailure extends NewTryTransactionState {
  final String message;

  const TransactionLoadFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
