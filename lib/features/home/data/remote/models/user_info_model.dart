import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mini_wallet/features/home/domain/entities/user_info_entity.dart';

class UserInfoModel extends UserInfoEntity {
  const UserInfoModel({
    required String name,
    required String email,
    String? userImage,
  }) : super(
          email: email,
          name: name,
          userImage: userImage,
        );

  factory UserInfoModel.fromJson(DocumentSnapshot doc) {
    return UserInfoModel(
        name: doc['name'], email: doc['email'], userImage: doc['userImage']);
  }
}
