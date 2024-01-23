import 'package:dartz/dartz.dart';
import 'package:mini_wallet/core/errors/failure.dart';
import 'package:mini_wallet/features/home/data/remote/models/transaction_model.dart';
import 'package:mini_wallet/features/home/domain/entities/deposit_entity.dart';
import 'package:mini_wallet/features/home/domain/entities/header_entity.dart';
import 'package:mini_wallet/features/home/domain/entities/transaction_entity.dart';
import 'package:mini_wallet/features/home/domain/entities/user_info_entity.dart';
import 'package:mini_wallet/features/home/domain/entities/withdraw_entity.dart';

abstract class BaseWalletTransactionRepository {
  Future<Either<Failure, Unit>> deposit({required DepositEntity depositEntity});
  Future<Either<Failure, Unit>> withdraw(
      {required WithdrawEntity withdrawEntity});
  Future<Either<Failure, List<TransactionEntity>>> getAllTransactions();
  Future<Either<Failure, Stream<List<TransactionModel>>>>
      tryGetAllDataTransaction();
  Future<Either<Failure, HeaderEntity>> getTotalAndIncomeExpense();
  Future<Either<Failure, List<TransactionEntity>>> getTransactionsQuery(
      {required String type,
      required DateTime startDate,
      required DateTime endDate});
  Future<Either<Failure, UserInfoEntity>> getUserInfo({
    required String userId,
  });
}
