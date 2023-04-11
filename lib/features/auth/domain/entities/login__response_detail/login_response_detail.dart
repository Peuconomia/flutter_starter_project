import 'package:freezed_annotation/freezed_annotation.dart';

import '../user_detail/user_detail.dart';

part 'login_response_detail.freezed.dart';
part 'login_response_detail.g.dart';

@freezed
class LoginResponseDetail with _$LoginResponseDetail {
  const factory LoginResponseDetail({
    @JsonKey(name: 'token') required String token,
    @JsonKey(name: 'user') required UserDetail userDetail,
  }) = _LoginResponseDetail;

  factory LoginResponseDetail.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDetailFromJson(json);
}
