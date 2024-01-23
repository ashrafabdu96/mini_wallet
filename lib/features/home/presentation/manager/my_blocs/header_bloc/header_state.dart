part of 'header_bloc.dart';

abstract class HeaderState extends Equatable {
  const HeaderState();
  @override
  List<Object?> get props => [];
}

class HeaderInitialState extends HeaderState {
  const HeaderInitialState();
  @override
  List<Object?> get props => [];
}

class HeaderLoadingState extends HeaderState {
  const HeaderLoadingState();
  @override
  List<Object?> get props => [];
}

class HeaderSuccessState extends HeaderState {
  final HeaderEntity headerEntity;
  const HeaderSuccessState({required this.headerEntity});
  @override
  List<Object?> get props => [headerEntity];
}

class HeaderFailureState extends HeaderState {
  final String message;
  const HeaderFailureState({required this.message});
  @override
  List<Object?> get props => [message];
}
