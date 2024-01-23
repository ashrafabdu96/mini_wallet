import 'package:mini_wallet/features/home/domain/entities/withdraw_entity.dart';

class WithdrawModel extends WithdrawEntity {
  const WithdrawModel({
    required String userId,
    required double amount,
    required String destination,
    required String destinationAccount,
  }) : super(
          userId: userId,
          amount: amount,
          destination: destination,
          destinationAccount: destinationAccount,
        );
  factory WithdrawModel.fromJson(Map<String, dynamic> json) {
    return WithdrawModel(
      userId: json["uid"],
      amount: json["amount"],
      destination: json["destination"],
      destinationAccount: json["destinationAccount"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'amount': amount,
      'destination': destination,
      'destinationAccount': destinationAccount,
    };
  }
}
