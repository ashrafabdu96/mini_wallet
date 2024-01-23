import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TransactionEntity extends Equatable {
  final double amount;
  final Timestamp date;
  final String type;
  final String destinationOrSource;
  final String destinationOrSourceAccount;

  const TransactionEntity({
    required this.type,
    required this.amount,
    required this.date,
    required this.destinationOrSource,
    required this.destinationOrSourceAccount,
  });
  @override
  List<Object> get props => [
        amount,
        date,
        destinationOrSource,
        destinationOrSourceAccount,
        type,
      ];
}
