import 'package:dartz/dartz.dart';
import 'package:mini_wallet/core/errors/failure.dart';
import 'package:mini_wallet/core/usecases/usecases.dart';
import 'package:mini_wallet/features/home/domain/entities/deposit_entity.dart';
import 'package:mini_wallet/features/home/domain/repositories/base_wallet_transaction_repository.dart';

class DepositUseCase extends BaseUseCase<Unit, DepositEntity> {
  final BaseWalletTransactionRepository baseWalletTransactionRepository;
  DepositUseCase({required this.baseWalletTransactionRepository});
  @override
  Future<Either<Failure, Unit>> call({required DepositEntity params}) async {
    return await baseWalletTransactionRepository.deposit(depositEntity: params);
  }
}
