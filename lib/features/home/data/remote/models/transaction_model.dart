import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mini_wallet/features/home/domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  const TransactionModel({
    required double amount,
    required Timestamp date,
    required String destinationOrSource,
    required String destinationOrSourceAccount,
    required String type,
  }) : super(
          amount: amount,
          date: date,
          destinationOrSource: destinationOrSource,
          destinationOrSourceAccount: destinationOrSourceAccount,
          type: type,
        );

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'date': date,
      'type': type,
      'destinationOrSource': destinationOrSource,
      'destinationOrSourceAccount': destinationOrSourceAccount,
    };
  }

  factory TransactionModel.fromDepositDoc(DocumentSnapshot doc) {
    return TransactionModel(
      amount: doc['amount'] as double,
      date: doc['date'] as Timestamp,
      type: "deposits",
      destinationOrSource: doc['source'] as String,
      destinationOrSourceAccount: doc['sourceAccount'] as String,
    );
  }
  factory TransactionModel.fromTransaction(DocumentSnapshot doc) {
    return TransactionModel(
      amount: doc['amount'] as double,
      date: doc['date'] as Timestamp,
      type: doc["type"],
      destinationOrSource: (doc["type"] == "deposit"
          ? doc['source']
          : doc["destination"]) as String,
      destinationOrSourceAccount: (doc["type"] == "deposit"
          ? doc['sourceAccount']
          : doc['destinationAccount']) as String,
    );
  }

  factory TransactionModel.fromWithdrawDoc(
    DocumentSnapshot doc,
  ) {
    return TransactionModel(
      amount: doc['amount'] as double,
      date: doc['date'] as Timestamp,
      type: "withdrawals",
      destinationOrSource: doc['destination'] as String,
      destinationOrSourceAccount: doc['destinationAccount'] as String,
    );
  }

  factory TransactionModel.fromDepositMap(
    Map<String, dynamic> map,
  ) {
    return TransactionModel(
      amount: map['amount'] as double,
      date: map['date'] as Timestamp,
      type: "deposits",
      destinationOrSource: map['source'] as String,
      destinationOrSourceAccount: map['sourceAccount'] as String,
    );
  }

  factory TransactionModel.fromWithdrawMap(
    Map<String, dynamic> map,
  ) {
    return TransactionModel(
      amount: map['amount'] as double,
      date: map['date'] as Timestamp,
      type: "withdrawals",
      destinationOrSource: map['destination'] as String,
      destinationOrSourceAccount: map['destinationAccount'] as String,
    );
  }

  @override
  List<Object> get props => [
        amount,
        type,
        destinationOrSourceAccount,
        destinationOrSource,
        date,
      ];
}
