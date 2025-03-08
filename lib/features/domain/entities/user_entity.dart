import 'package:equatable/equatable.dart';
import 'package:mgym/features/data/models/user_model.dart';

class UserEntity extends Equatable {
  final String fullName;
  final String email;
  final String nickName;
  final String phoneNum;
  final double hight;
  final double weight;
  final int age;
  final String gender;
  final String photoUrl;
  final bool isSaved;
  final String userType;
  final String id;
  const UserEntity({
    required this.id,
    required this.photoUrl,
    required this.isSaved,
    required this.userType,
    required this.phoneNum,
    required this.hight,
    required this.weight,
    required this.fullName,
    required this.email,
    required this.nickName,
    required this.age,
    required this.gender,
  });

  UserEntity cobyWith(
      {String? fullName,
      String? email,
      String? nickName,
      String? phoneNum,
      double? hight,
      double? weight,
      int? age,
      String? gender,
      String? photoUrl,
      bool? isSaved,
      String? userType,
      String? id}) {
    return UserEntity(
      photoUrl: photoUrl ?? this.photoUrl,
      phoneNum: phoneNum ?? this.phoneNum,
      hight: hight ?? this.hight,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      nickName: nickName ?? this.nickName,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      weight: weight ?? this.weight,
      isSaved: isSaved ?? this.isSaved,
      userType: userType ?? this.userType,
      id: id ?? this.id,
    );
  }

  UserModel get toModel => UserModel(
      phoneNum: phoneNum,
      hight: hight,
      weight: weight,
      fullName: fullName,
      email: email,
      nickName: nickName,
      age: age,
      gender: gender,
      photoUrl: photoUrl,
      isSaved: isSaved,
      userType: userType,
      id: id);

  @override
  List<Object?> get props => [
        fullName,
        email,
        nickName,
        phoneNum,
        hight,
        weight,
        age,
        gender,
      ];
}
