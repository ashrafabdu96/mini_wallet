import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mini_wallet/features/home/domain/entities/header_entity.dart';

class HeaderModel extends HeaderEntity {
  HeaderModel({
    double? balance,
    // Timestamp? dateCreated,
    double? totalDeposits,
    String? currency,
    double? totalWithdrawals,
  }) : super(
          balance: balance,
          currency: currency,
          // dateCreated: dateCreated,
          totalDeposits: totalDeposits,
          totalWithdrawals: totalWithdrawals,
        );
  factory HeaderModel.fromSnapShot(DocumentSnapshot doc) {
    return HeaderModel(
      totalWithdrawals: doc['totalWithdrawals'].toDouble(),
      totalDeposits: doc['totalDeposits'].toDouble(),
      // dateCreated: doc['dateCreated'] as Timestamp,
      currency: doc['currency'],
      balance: doc['balance'].toDouble(),
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['balance'] = balance;
    // data['dateCreated'] = dateCreated;
    data['totalDeposits'] = totalDeposits;
    data['currency'] = currency;
    data['totalWithdrawals'] = totalWithdrawals;
    return data;
  }
}
