import 'package:freezed_annotation/freezed_annotation.dart';

import '../user_detail/user_detail.dart';

part 'register_response_detail.freezed.dart';
part 'register_response_detail.g.dart';

@freezed
class RegisterResponseDetail with _$RegisterResponseDetail {
  const factory RegisterResponseDetail({
    @JsonKey(name: 'token') required String token,
    @JsonKey(name: 'user') required UserDetail userDetail,
  }) = _RegisterResponseDetail;

  factory RegisterResponseDetail.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseDetailFromJson(json);
}
