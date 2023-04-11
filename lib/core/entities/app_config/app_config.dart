import 'package:app/features/auth/domain/entities/login_detail/login_detail.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../features/auth/data/models/user.dart';

part 'app_config.freezed.dart';
part 'app_config.g.dart';

@freezed
class AppConfig with _$AppConfig {
  factory AppConfig({
    @Default(false) bool isWelcomeScreenShown,
    UserModel? user,
    LoginDetail? savedCredentials,
  }) = _AppConfig;

  factory AppConfig.fromJson(Map<String, dynamic> json) =>
      _$AppConfigFromJson(json);
}
