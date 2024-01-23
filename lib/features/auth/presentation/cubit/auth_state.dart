part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {
  const AuthInitialState();
  @override
  List<Object> get props => [];
}
// class AuthDarkState extends AuthState {}

class AuthSuccessState extends AuthState {
  final User? user;

  const AuthSuccessState({this.user});
  @override
  List<Object?> get props => [user];
}

class AuthLoadingState extends AuthState {
  const AuthLoadingState();
  @override
  List<Object> get props => [];
}

class AuthLoadingGoogleSignInState extends AuthState {
  const AuthLoadingGoogleSignInState();
  @override
  List<Object> get props => [];
}

class AuthErrorState extends AuthState {
  final String errorMessage;

  const AuthErrorState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
