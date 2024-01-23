import 'package:dartz/dartz.dart';
import 'package:mini_wallet/core/errors/exceptions.dart';
import 'package:mini_wallet/core/errors/failure.dart';
import 'package:mini_wallet/core/helpers/network_info.dart';
import 'package:mini_wallet/features/home/data/remote/models/transaction_model.dart';
import 'package:mini_wallet/features/home/domain/entities/deposit_entity.dart';
import 'package:mini_wallet/features/home/domain/entities/header_entity.dart';
import 'package:mini_wallet/features/home/domain/entities/transaction_entity.dart';
import 'package:mini_wallet/features/home/domain/entities/user_info_entity.dart';
import 'package:mini_wallet/features/home/domain/entities/withdraw_entity.dart';
import 'package:mini_wallet/features/home/domain/repositories/base_wallet_transaction_repository.dart';

import '../remote/data_sources/remote_data_source.dart';

class WalletTransactionRepositoryImpl extends BaseWalletTransactionRepository {
  final NetworkInfo networkInfo;
  final RemoteDataSource remoteDataSourceImpl;

  WalletTransactionRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSourceImpl,
  });
  @override
  Future<Either<Failure, Unit>> deposit(
      {required DepositEntity depositEntity}) async {
    if (await networkInfo.isConnected) {
      try {
        return await remoteDataSourceImpl
            .deposit(depositEntity: depositEntity)
            .then((value) => Right(value));
      } on ServerException catch (e) {
        return Left(Failure(failureMessage: e.serverMessage));
      }
    } else {
      return const Left(
          Failure(failureMessage: "Internet Failure Connection Failure"));
    }
  }

  @override
  Future<Either<Failure, Unit>> withdraw(
      {required WithdrawEntity withdrawEntity}) async {
    if (await networkInfo.isConnected) {
      try {
        return await remoteDataSourceImpl
            .withdraw(withdrawEntity: withdrawEntity)
            .then((value) => Right(value));
      } on ServerException catch (e) {
        return Left(Failure(failureMessage: e.serverMessage));
      }
    } else {
      return const Left(
          Failure(failureMessage: "Internet Failure Connection Failure"));
    }
  }

  @override
  Future<Either<Failure, List<TransactionEntity>>> getAllTransactions() async {
    if (await networkInfo.isConnected) {
      try {
        return await remoteDataSourceImpl.getTransactions().then(
              (value) => Right(value),
            );
      } on ServerException catch (e) {
        return Left(
          Failure(
            failureMessage: e.toString(),
          ),
        );
      }
    } else {
      return const Left(
          Failure(failureMessage: "Internet Failure Connection Failure"));
    }
  }

  @override
  Future<Either<Failure, Stream<List<TransactionModel>>>>
      tryGetAllDataTransaction() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = remoteDataSourceImpl.tryGetAllDataTransaction();
        return Right(
          remoteDataSourceImpl.tryGetAllDataTransaction(),
        );
      } on ServerException catch (e) {
        return Left(
          Failure(
            failureMessage: e.toString(),
          ),
        );
      }
    } else {
      return const Left(
          Failure(failureMessage: "Internet Failure Connection Failure"));
    }
  }

  @override
  Future<Either<Failure, HeaderEntity>> getTotalAndIncomeExpense() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSourceImpl.getTotalAndIncomeExpense();

        return Right(result);
      } on ServerException catch (e) {
        return Left(
          Failure(
            failureMessage: e.toString(),
          ),
        );
      }
    } else {
      return const Left(
          Failure(failureMessage: "Internet Failure Connection Failure"));
    }
  }

  @override
  Future<Either<Failure, List<TransactionEntity>>> getTransactionsQuery(
      {required String type,
      required DateTime startDate,
      required DateTime endDate}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSourceImpl.getTransactionsQuery(
          type: type,
          startDate: startDate,
          endDate: endDate,
        );
        print("***${result}***");
        return Right(result);
      } on ServerException catch (e) {
        return Left(
          Failure(
            failureMessage: e.toString(),
          ),
        );
      }
    } else {
      return const Left(
          Failure(failureMessage: "Internet Failure Connection Failure"));
    }
  }

  @override
  Future<Either<Failure, UserInfoEntity>> getUserInfo(
      {required String userId}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSourceImpl.getUserInfo(userId: userId);
        print("***${result}***");
        return Right(result);
      } on ServerException catch (e) {
        return Left(
          Failure(
            failureMessage: e.toString(),
          ),
        );
      }
    } else {
      return const Left(
          Failure(failureMessage: "Internet Failure Connection Failure"));
    }
  }
}
