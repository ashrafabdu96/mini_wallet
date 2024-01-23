import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mini_wallet/features/home/domain/entities/user_info_entity.dart';
import 'package:mini_wallet/features/home/domain/use_cases/get_user_info_usecase.dart';

part 'user_info_state.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  final GetUSerInfoUseCase getUSerInfoUseCase;
  UserInfoCubit({required this.getUSerInfoUseCase})
      : super(const UserInfoInitial());

  getUserInfo() async {
    emit(const UserInfoLoading());
    final result = await getUSerInfoUseCase(
      params: UserParams(
        userId: FirebaseAuth.instance.currentUser!.uid.toString(),
      ),
    );
    result.fold(
      (l) => emit(
        UserInfoFailure(
          errorMessage: l.failureMessage,
        ),
      ),
      (r) => emit(
        UserInfoSuccess(
          userInfoEntity: r,
        ),
      ),
    );
  }
}
