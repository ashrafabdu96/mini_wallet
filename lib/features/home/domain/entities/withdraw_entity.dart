import 'package:equatable/equatable.dart';

class WithdrawEntity extends Equatable {
  final String userId;
  final double amount;
  final String destination;
  final String destinationAccount;

  const WithdrawEntity({
    required this.userId,
    required this.amount,
    required this.destination,
    required this.destinationAccount,
  });
  @override
  List<Object> get props => [
        userId,
        amount,
        destination,
        destinationAccount,
      ];
}
