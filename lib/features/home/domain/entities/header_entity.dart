import 'package:equatable/equatable.dart';

class HeaderEntity extends Equatable {
  final double? balance;

  // Timestamp? dateCreated;
  final double? totalDeposits;
  final String? currency;
  final double? totalWithdrawals;

  const HeaderEntity(
      {this.balance,
      // this.dateCreated,
      this.totalDeposits,
      this.currency,
      this.totalWithdrawals});

  @override
  List<Object?> get props => [
        balance,
        totalDeposits,
        currency,
        totalWithdrawals,
      ];
}
