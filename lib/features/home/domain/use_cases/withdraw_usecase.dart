import 'package:dartz/dartz.dart';
import 'package:mini_wallet/core/errors/failure.dart';
import 'package:mini_wallet/core/usecases/usecases.dart';
import 'package:mini_wallet/features/home/domain/entities/withdraw_entity.dart';
import 'package:mini_wallet/features/home/domain/repositories/base_wallet_transaction_repository.dart';

class WithdrawUseCase extends BaseUseCase<Unit, WithdrawEntity> {
  final BaseWalletTransactionRepository baseWalletTransactionRepository;
  WithdrawUseCase({required this.baseWalletTransactionRepository});
  @override
  Future<Either<Failure, Unit>> call({required WithdrawEntity params}) async {
    return await baseWalletTransactionRepository.withdraw(
        withdrawEntity: params);
  }
}
