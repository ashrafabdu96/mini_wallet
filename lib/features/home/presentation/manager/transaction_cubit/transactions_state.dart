part of 'transactions_cubit.dart';

class TransactionsState extends Equatable {
  final RequestStatus depositStatus;
  final String depositMessage;
  final RequestStatus withdrawStatus;
  final String withdrawMessage;
  final List<TransactionEntity> transactions;
  final RequestStatus transactionStatus;
  final String transactionMessage;

  const TransactionsState({
    this.transactionStatus = RequestStatus.none,
    this.transactionMessage = '',
    this.transactions = const [],
    this.withdrawStatus = RequestStatus.none,
    this.withdrawMessage = '',
    this.depositStatus = RequestStatus.none,
    this.depositMessage = '',
  });

  @override
  List<Object> get props => [
        depositStatus,
        depositMessage,
        withdrawStatus,
        withdrawMessage,
        transactions,
        transactionStatus,
        transactionMessage,
      ];

  TransactionsState copyWith({
    RequestStatus? depositStatus,
    String? depositMessage,
    RequestStatus? withdrawStatus,
    String? withdrawMessage,
    List<TransactionEntity>? transactions,
    RequestStatus? transactionStatus,
    String? transactionMessage,
  }) {
    return TransactionsState(
      depositStatus: depositStatus ?? this.depositStatus,
      depositMessage: depositMessage ?? this.depositMessage,
      withdrawStatus: withdrawStatus ?? this.withdrawStatus,
      withdrawMessage: withdrawMessage ?? this.withdrawMessage,
      transactions: transactions ?? this.transactions,
      transactionStatus: transactionStatus ?? this.transactionStatus,
      transactionMessage: transactionMessage ?? this.transactionMessage,
    );
  }
}
