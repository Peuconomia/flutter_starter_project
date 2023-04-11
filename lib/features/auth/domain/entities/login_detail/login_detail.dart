import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_detail.freezed.dart';
part 'login_detail.g.dart';

@freezed
class LoginDetail with _$LoginDetail {
  const factory LoginDetail({
    @Default('') String username,
    @Default('') String password,
    @Default(false) bool rememberMe,
  }) = _LoginDetail;

  factory LoginDetail.fromJson(Map<String, dynamic> json) =>
      _$LoginDetailFromJson(json);
}
