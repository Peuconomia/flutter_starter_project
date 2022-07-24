import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_failures.freezed.dart';

@freezed
class AppFailure with _$AppFailure {
  factory AppFailure.noInternetConnection({required String message}) =
      _NoInternetConnectionFailure;
  factory AppFailure.unAuthorized({required String message}) =
      _UnAuthorizedFailure;
  factory AppFailure.forbidden({required String message}) = _ForbiddenFailure;
  factory AppFailure.formatNotParsable({required String message}) =
      _FormatNotParsableFailure;
  factory AppFailure.internalServerFailure({required String message}) =
      _InternalServerFailure;
}
