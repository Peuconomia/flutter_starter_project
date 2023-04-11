import 'package:freezed_annotation/freezed_annotation.dart';

part 'social_share_options.freezed.dart';

@freezed
class SocialShareOption with _$SocialShareOption {
  factory SocialShareOption({
    @Default(false) bool enableFacebook,
    @Default(false) bool enableInstagram,
    @Default(false) bool enableTwitter,
  }) = _SocialShareOption;
}
