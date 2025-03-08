import 'package:mgym/features/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel(
      {required super.phoneNum,
      required super.hight,
      required super.weight,
      required super.fullName,
      required super.email,
      required super.nickName,
      required super.age,
      required super.gender,
      required super.photoUrl,
      required super.isSaved,
      required super.userType,
      required super.id});

  Map<String, dynamic> toMap() => {
        UserKeys.id: id,
        UserKeys.fullName: fullName,
        UserKeys.nickName: nickName,
        UserKeys.email: email,
        UserKeys.age: age,
        UserKeys.gender: gender,
        UserKeys.phoneNum: phoneNum,
        UserKeys.hight: hight,
        UserKeys.photoUrl: photoUrl,
        UserKeys.weight: weight,
        UserKeys.isSaved: isSaved,
        UserKeys.userType: userType,
      };

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        id: map[UserKeys.id],
        fullName: map[UserKeys.fullName],
        nickName: map[UserKeys.nickName],
        email: map[UserKeys.email],
        age: map[UserKeys.age],
        gender: map[UserKeys.gender],
        phoneNum: map[UserKeys.phoneNum],
        hight: map[UserKeys.hight],
        weight: map[UserKeys.weight],
        isSaved: map[UserKeys.isSaved],
        userType: map[UserKeys.userType],
        photoUrl: map[UserKeys.photoUrl],
      );
  // factory toMap(UserModel model) => {};
}

class UserKeys {
  static const id = 'id';
  static const photoUrl = 'photoUrl';
  static const isSaved = 'isSaved';
  static const userType = 'userType';
  static const phoneNum = 'phoneNum';
  static const hight = 'hight';
  static const weight = 'weight';
  static const fullName = 'fullName';
  static const email = 'email';
  static const nickName = 'nickName';
  static const age = 'age';
  static const gender = 'gender';
  static const model = 'model';
}
