import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mini_wallet/core/errors/failure.dart';
import 'package:mini_wallet/core/usecases/usecases.dart';
import 'package:mini_wallet/features/home/domain/entities/transaction_entity.dart';
import 'package:mini_wallet/features/home/domain/repositories/base_wallet_transaction_repository.dart';

class TransactionsQueryUsecase
    extends BaseUseCase<List<TransactionEntity>, TransactionsQueryParameters> {
  final BaseWalletTransactionRepository baseWalletTransactionRepository;

  TransactionsQueryUsecase({required this.baseWalletTransactionRepository});

  @override
  Future<Either<Failure, List<TransactionEntity>>> call(
      {required TransactionsQueryParameters params}) async {
    return await baseWalletTransactionRepository.getTransactionsQuery(
        type: params.type,
        startDate: params.startDate,
        endDate: params.endDate);
  }
}

class TransactionsQueryParameters extends Equatable {
  final String type;
  final DateTime startDate;
  final DateTime endDate;
  const TransactionsQueryParameters(
      {required this.endDate, required this.type, required this.startDate});
  @override
  List<Object?> get props => [type, startDate, endDate];
}
