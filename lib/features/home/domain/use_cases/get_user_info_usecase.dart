import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mini_wallet/core/errors/failure.dart';
import 'package:mini_wallet/core/usecases/usecases.dart';
import 'package:mini_wallet/features/home/domain/entities/user_info_entity.dart';
import 'package:mini_wallet/features/home/domain/repositories/base_wallet_transaction_repository.dart';

class GetUSerInfoUseCase extends BaseUseCase<UserInfoEntity, UserParams> {
  final BaseWalletTransactionRepository baseWalletTransactionRepository;

  GetUSerInfoUseCase({
    required this.baseWalletTransactionRepository,
  });
  @override
  Future<Either<Failure, UserInfoEntity>> call(
      {required UserParams params}) async {
    return await baseWalletTransactionRepository.getUserInfo(
        userId: params.userId);
  }
}

class UserParams extends Equatable {
  final String userId;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  const UserParams({
    required this.userId,
  });
}
