part of 'user_info_cubit.dart';

abstract class UserInfoState extends Equatable {
  const UserInfoState();
  @override
  List<Object> get props => [];
}

class UserInfoInitial extends UserInfoState {
  const UserInfoInitial();
  @override
  List<Object> get props => [];
}

class UserInfoLoading extends UserInfoState {
  const UserInfoLoading();
  @override
  List<Object> get props => [];
}

class UserInfoSuccess extends UserInfoState {
  const UserInfoSuccess({required this.userInfoEntity});
  final UserInfoEntity userInfoEntity;
  @override
  List<Object> get props => [];
}

class UserInfoFailure extends UserInfoState {
  final String errorMessage;
  const UserInfoFailure({required this.errorMessage});
  @override
  List<Object> get props => [];
}
