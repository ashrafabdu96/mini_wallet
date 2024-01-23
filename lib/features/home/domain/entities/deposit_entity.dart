import 'package:equatable/equatable.dart';

class DepositEntity extends Equatable {
  final String userId;
  final double amount;
  final String source;
  final String sourceAccount;

  @override
  List<Object> get props => [
        userId,
        amount,
        source,
        sourceAccount,
      ];

  const DepositEntity({
    required this.userId,
    required this.amount,
    required this.source,
    required this.sourceAccount,
  });
}
