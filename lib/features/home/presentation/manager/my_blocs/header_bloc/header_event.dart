part of 'header_bloc.dart';

abstract class HeaderEvent extends Equatable {
  const HeaderEvent();
}

class GetHeaderInfoEvent extends HeaderEvent {
  const GetHeaderInfoEvent();
  @override
  List<Object?> get props => [];
}
