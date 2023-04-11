import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_exceptions.freezed.dart';

@freezed
class AppException with _$AppException {
  factory AppException.noInternetConnection({required String message}) =
      _NoInternetConnectionException;

  factory AppException.badRequest({required String message}) =
      _BadRequestException;

  factory AppException.unAuthorized({required String message}) =
      _UnAuthorizedException;

  factory AppException.unProcessableEntity({required String message}) =
      _UnProcessableEntityException;

  factory AppException.forbidden({required String message}) =
      _ForbiddenException;

  factory AppException.formatNotParsable({required String message}) =
      _FormatNotParsableException;

  factory AppException.internalServerException({required String message}) =
      _InternalServerException;

  factory AppException.cacheException({required String message}) =
      _CacheException;

  factory AppException.unknownException({required String message}) =
      _UnknownException;

  factory AppException.timeOutException({required String message}) =
      _TimeOutException;

  factory AppException.notFoundException({required String message}) =
      _NotFoundException;
}
