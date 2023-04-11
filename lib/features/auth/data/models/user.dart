import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel extends User {
  const UserModel({
    required super.idToken,
    required super.refreshToken,
    required super.fcmToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonMap) =>
      _$UserModelFromJson(jsonMap);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
