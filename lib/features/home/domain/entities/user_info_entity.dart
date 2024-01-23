import 'package:equatable/equatable.dart';

class UserInfoEntity extends Equatable {
  final String name;
  final String email;
  final String? userImage;

  const UserInfoEntity({
    required this.name,
    required this.email,
    this.userImage,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        userImage,
      ];
}
