import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_detail.freezed.dart';

@freezed
class RegisterDetail with _$RegisterDetail {
  const factory RegisterDetail({
    @Default('') String email,
    @Default('') String password,
    @Default('') String fullName,
    @Default(false) bool hasUserAgreed,
  }) = _RegisterDetail;
}
