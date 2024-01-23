import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mini_wallet/core/errors/failure.dart';
import 'package:mini_wallet/core/usecases/usecases.dart';
import 'package:mini_wallet/features/home/domain/entities/transaction_entity.dart';
import 'package:mini_wallet/features/home/domain/repositories/base_wallet_transaction_repository.dart';

class TryGetAllTransactionsUsecase
    extends BaseUseCase<Stream<List<TransactionEntity>>, NoParameters> {
  final BaseWalletTransactionRepository baseWalletTransactionRepository;

  TryGetAllTransactionsUsecase({required this.baseWalletTransactionRepository});
  @override
  Future<Either<Failure, Stream<List<TransactionEntity>>>> call(
      {required NoParameters params}) async {
    return await baseWalletTransactionRepository.tryGetAllDataTransaction();
  }
}

class NoParameters extends Equatable {
  const NoParameters();
  @override
  List<Object?> get props => [];
}
