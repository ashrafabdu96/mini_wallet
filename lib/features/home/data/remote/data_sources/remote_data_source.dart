import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:mini_wallet/core/errors/exceptions.dart';
import 'package:mini_wallet/features/home/data/remote/models/transaction_model.dart';
import 'package:mini_wallet/features/home/data/remote/models/user_info_model.dart';
import 'package:mini_wallet/features/home/domain/entities/deposit_entity.dart';
import 'package:mini_wallet/features/home/domain/entities/withdraw_entity.dart';

import '../models/header_model.dart';

abstract class RemoteDataSource {
  Future<Unit> deposit({required DepositEntity depositEntity});
  Future<Unit> withdraw({required WithdrawEntity withdrawEntity});
  // Stream<List<TransactionEntity>>
  // Stream<List<TransactionModel>> getAllTransactions();
  Future<List<TransactionModel>> getTransactions();
  Stream<List<TransactionModel>> tryGetAllDataTransaction();
  Future<HeaderModel> getTotalAndIncomeExpense();
  Future<List<TransactionModel>> getTransactionsQuery(
      {required String type,
      required DateTime startDate,
      required DateTime endDate});
  Future<UserInfoModel> getUserInfo({
    required String userId,
  });
}

class RemoteDataSourceImpl extends RemoteDataSource {
  @override
  Future<Unit> deposit({required DepositEntity depositEntity}) async {
    DocumentReference userRef = FirebaseFirestore.instance
        .collection("users")
        .doc(depositEntity.userId);
    DocumentReference walletRef =
        userRef.collection("wallet").doc(depositEntity.userId);
    DocumentReference depositRef = walletRef.collection("transaction").doc();

    try {
      await depositRef.set({
        "amount": depositEntity.amount,
        "date": Timestamp.now(),
        "type": "deposit",
        "source": depositEntity.source,
        "sourceAccount": depositEntity.sourceAccount,
        "destination": "",
        "destinationAccount": "",
      });

      DocumentSnapshot<Map<String, dynamic>> walletSnapshot =
          await walletRef.get() as DocumentSnapshot<Map<String, dynamic>>;
      // Map<String,dynamic> walletSnapshot = (await walletRef.get()) as Map<String, dynamic>;

      double balance = walletSnapshot.data()!["balance"].toDouble();
      balance = balance + depositEntity.amount;
      double totalDeposits = walletSnapshot.data()!["totalDeposits"].toDouble();
      totalDeposits = totalDeposits + depositEntity.amount;

      await walletRef.update({
        "balance": balance,
        "totalDeposits": totalDeposits,
      });

      return unit;
    } on FirebaseException catch (e) {
      throw ServerException(e.message.toString());
    }
  }

  @override
  Future<Unit> withdraw({required WithdrawEntity withdrawEntity}) async {
    //first we get the doc-ref of user which that contain
    // the user info and sub-collections of user's wallet and his trans actions
    DocumentReference userRef = FirebaseFirestore.instance
        .collection("users")
        .doc(withdrawEntity.userId);
    //second we  get the doc-ref of the wallet that contains the wallet info and  transactions
    DocumentReference walletRef =
        userRef.collection("wallet").doc(withdrawEntity.userId);

    //third we get the withdraw doc from the wallet ref for specific user
    DocumentReference withdrawRef = walletRef.collection("transaction").doc();

    try {
      DocumentSnapshot<Map<String, dynamic>> walletSnapshot =
          (await walletRef.get()) as DocumentSnapshot<Map<String, dynamic>>;
      // Map<String,dynamic> walletSnapshot = (await walletRef.get()) as Map<String, dynamic>;
      //get the balance to update the total after the transaction

      double balance = walletSnapshot.data()!["balance"].toDouble();
      if (withdrawEntity.amount > balance) {
        throw const ServerException("Sorry You Don't Have Enough Balance");
        // throw ServerException(AppStrings.balanceNotEnough.toString());
      }
      // first we set the transaction information
      await withdrawRef.set({
        "amount": withdrawEntity.amount,
        "date": Timestamp.now(),
        "type": "withdraw",
        "destination": withdrawEntity.destination,
        "destinationAccount": withdrawEntity.destinationAccount,
        "source": "",
        "sourceAccount": "",
      });
//second we get the wallet info to update the total after the
// transaction and add the amount of the withdraw to the total of with draw

      //get the totalWithdrawals to update the totalWithdrawals
      double totalWithdrawals =
          walletSnapshot.data()!["totalWithdrawals"].toDouble() ?? 0.0;
      // update the balance after the transaction
      balance = balance -
          withdrawEntity
              .amount; //which is balance=balance-withdrawEntity.amount
      // update the totalWithdrawals
      totalWithdrawals = totalWithdrawals + withdrawEntity.amount;
      //update both
      await walletRef.update({
        "balance": balance,
        "totalWithdrawals": totalWithdrawals,
      });
      return unit;
    } on FirebaseException catch (e) {
      throw ServerException(e.message.toString());
    }
  }

  @override
  // Stream<List<TransactionEntity>>
  Future<List<TransactionModel>> getTransactions() async {
    String userId = FirebaseAuth.instance.currentUser!.uid.toString();
    DocumentReference userRef =
        FirebaseFirestore.instance.collection("users").doc(userId);
    DocumentReference walletRef = userRef.collection("wallet").doc(userId);
    var transactions = <TransactionModel>[];
    try {
      var test = walletRef.collection("withdrawals").snapshots().listen(
            (data) => data.docs
                .map(
                  (e) => TransactionModel(
                      amount: e['amount'],
                      date: e['date'],
                      destinationOrSource: e['destination'],
                      destinationOrSourceAccount: e['destinationAccount'],
                      type: 'withdrawals'),
                )
                .toList(),
            onDone: () {},
          );
      var d;
      var testData = test.onData((data) {
        d = data.docs
            .map(
              (e) => TransactionModel(
                  amount: e['amount'],
                  date: e['date'],
                  destinationOrSource: e['destination'],
                  destinationOrSourceAccount: e['destinationAccount'],
                  type: 'withdrawals'),
            )
            .toList();
      });

      ///test

      ///withdraw****************
      // Stream<QuerySnapshot<Map<String, dynamic>>>

      var withdrawRef = await walletRef
          .collection("withdrawals")
          .snapshots()
          .asyncMap(
            (event) => event.docs
                .map(
                  (e) => TransactionModel.fromWithdrawMap(
                    e.data(),
                  ),
                )
                .toList(),
          )
          .first;

      ///deposit*****************
      // Stream<QuerySnapshot<Map<String, dynamic>>>
      var depositRef = await walletRef
          .collection("deposits")
          .snapshots()
          .asyncMap(
            (event) => event.docs
                .map(
                  (e) => TransactionModel.fromDepositMap(
                    e.data(),
                  ),
                )
                .toList(),
          )
          .first;

      ///*****************
      transactions.clear();
      transactions = [...depositRef, ...withdrawRef];

      return transactions;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Servererror:$e");
      }
      throw ServerException(e.toString());
    }
  }

  @override
  Stream<List<TransactionModel>> tryGetAllDataTransaction() async* {
    String userId = FirebaseAuth.instance.currentUser!.uid.toString();
    DocumentReference userRef =
        FirebaseFirestore.instance.collection("users").doc(userId);
    DocumentReference walletRef = userRef.collection("wallet").doc(userId);
    // StreamController<List<TransactionModel>> streamController =
    //     StreamController<List<TransactionModel>>();
    //************************
    try {
      var transactionList = walletRef
          .collection('transaction')
          .orderBy('date', descending: true)
          .snapshots()
          .map(
            (event) => event.docs
                .map(
                  (e) => TransactionModel.fromTransaction(e),
                )
                .toList(),
          );

      yield* transactionList;
    } on FirebaseException catch (e) {
      throw ServerException(e.message.toString());
    }
  }

  @override
  Future<HeaderModel> getTotalAndIncomeExpense() async {
    String userId = FirebaseAuth.instance.currentUser!.uid.toString();
    DocumentReference userRef =
        FirebaseFirestore.instance.collection("users").doc(userId);
    DocumentReference walletRef = userRef.collection("wallet").doc(userId);
    try {
      final headerInfo = await walletRef.get();
      return HeaderModel.fromSnapShot(headerInfo);
    } on FirebaseException catch (e) {
      throw ServerException(e.message.toString());
    }
  }

  @override
  Future<List<TransactionModel>> getTransactionsQuery(
      {required String type,
      required DateTime startDate,
      required DateTime endDate}) async {
    String userId = FirebaseAuth.instance.currentUser!.uid.toString();
    DocumentReference userRef =
        FirebaseFirestore.instance.collection("users").doc(userId);
    DocumentReference walletRef = userRef.collection("wallet").doc(userId);
    try {
      QuerySnapshot result = await walletRef
          .collection("transaction")
          .where(
            'type',
            isEqualTo: type,
          )
          .where(
            'date',
            isGreaterThanOrEqualTo: Timestamp.fromDate(
              startDate.copyWith(
                year: startDate.year,
                month: startDate.month,
                day: startDate.day,
                hour: 0,
                minute: 0,
                second: 0,
                millisecond: 0,
                microsecond: 0,
              ),
            ),
          )
          .where(
            'date',
            isLessThanOrEqualTo: Timestamp.fromDate(endDate.copyWith(
              year: endDate.year,
              month: endDate.month,
              day: endDate.day,
              hour: 23,
              minute: 59,
              second: 59,
            )),
          )
          .orderBy('date', descending: true)
          .get();
      return result.docs
          .map<TransactionModel>((e) => TransactionModel.fromTransaction(e))
          .toList();
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e.message.toString());
      }
      throw ServerException(e.message.toString());
    }
  }

  @override
  Future<UserInfoModel> getUserInfo({required String userId}) async {
    String userId = FirebaseAuth.instance.currentUser!.uid.toString();
    DocumentReference userRef =
        FirebaseFirestore.instance.collection("users").doc(userId);
    try {
      final result =
          await userRef.get().then((value) => UserInfoModel.fromJson(value));
      return result;
    } on FirebaseException catch (e) {
      throw ServerException(e.message.toString());
    }
  }
}
