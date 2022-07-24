import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_exceptions.freezed.dart';

@freezed
class AppException with _$AppException {
  factory AppException.noInternetConnection({required String message}) =
      _NoInternetConnectionException;
  factory AppException.unAuthorized({required String message}) =
      _UnAuthorizedException;
  factory AppException.forbidden({required String message}) =
      _ForbiddenException;
  factory AppException.formatNotParsable({required String message}) =
      _FormatNotParsableException;
  factory AppException.internalServerException({required String message}) =
      _InternalServerException;
}
