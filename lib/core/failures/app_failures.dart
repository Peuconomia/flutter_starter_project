import 'package:freezed_annotation/freezed_annotation.dart';

import '../exceptions/app_exceptions.dart';

part 'app_failures.freezed.dart';

@freezed
class AppFailure with _$AppFailure {
  factory AppFailure.noInternetConnection({required String message}) =
      _NoInternetConnectionFailure;

  factory AppFailure.badRequest({required String message}) = _BadRequestFailure;

  factory AppFailure.unAuthorized({required String message}) =
      _UnAuthorizedFailure;

  factory AppFailure.unProcessableEntity({required String message}) =
      _UnProcessableEntityFailure;

  factory AppFailure.forbidden({required String message}) = _ForbiddenFailure;

  factory AppFailure.formatNotParsable({required String message}) =
      _FormatNotParsableFailure;

  factory AppFailure.internalServerFailure({required String message}) =
      _InternalServerFailure;

  factory AppFailure.cacheFailure({required String message}) = _CacheFailure;

  factory AppFailure.unknownFailure({required String message}) =
      _UnknownFailure;

  factory AppFailure.timeOutFailure({required String message}) =
      _TimeOutFailure;

  factory AppFailure.notFoundFailure({required String message}) =
      _NotFoundFailure;

  factory AppFailure.fromException(
    AppException exception,
  ) {
    return exception.map(
      noInternetConnection: (e) =>
          AppFailure.noInternetConnection(message: e.message),
      badRequest: (e) => AppFailure.badRequest(message: e.message),
      unAuthorized: (e) => AppFailure.unAuthorized(message: e.message),
      unProcessableEntity: (e) =>
          AppFailure.unProcessableEntity(message: e.message),
      forbidden: (e) => AppFailure.forbidden(message: e.message),
      formatNotParsable: (e) =>
          AppFailure.formatNotParsable(message: e.message),
      internalServerException: (e) =>
          AppFailure.internalServerFailure(message: e.message),
      cacheException: (e) => AppFailure.cacheFailure(message: e.message),
      unknownException: (e) => AppFailure.unknownFailure(message: e.message),
      timeOutException: (e) => AppFailure.timeOutFailure(message: e.message),
      notFoundException: (e) => AppFailure.notFoundFailure(message: e.message),
    );
  }
}
