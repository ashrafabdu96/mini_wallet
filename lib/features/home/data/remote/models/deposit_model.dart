import 'package:mini_wallet/features/home/domain/entities/deposit_entity.dart';

class DepositModel extends DepositEntity {
  const DepositModel({
    required String userId,
    required double amount,
    required String source,
    required String sourceAccount,
  }) : super(
          userId: userId,
          amount: amount,
          source: source,
          sourceAccount: sourceAccount,
        );
  factory DepositModel.fromJson(Map<String, dynamic> json) {
    return DepositModel(
      userId: json["uid"],
      amount: json["amount"],
      source: json["source"],
      sourceAccount: json["sourceAccount"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'amount': amount,
      'source': source,
      'sourceAccount': sourceAccount,
    };
  }
}
