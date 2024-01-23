import 'package:dartz/dartz.dart';
import 'package:mini_wallet/core/errors/failure.dart';
import 'package:mini_wallet/core/usecases/usecases.dart';
import 'package:mini_wallet/features/home/domain/entities/header_entity.dart';
import 'package:mini_wallet/features/home/domain/repositories/base_wallet_transaction_repository.dart';
import 'package:mini_wallet/features/home/domain/use_cases/try_get_all_transactions_usecase.dart';
// import 'package:firebase_learning/features/home/domain/use_cases/get_all_transactions_usecase.dart';

class GetTotalUseCase extends BaseUseCase<HeaderEntity, NoParameters> {
  final BaseWalletTransactionRepository baseWalletTransactionRepository;

  GetTotalUseCase({required this.baseWalletTransactionRepository});

  @override
  Future<Either<Failure, HeaderEntity>> call(
      {required NoParameters params}) async {
    return await baseWalletTransactionRepository.getTotalAndIncomeExpense();
  }
}
