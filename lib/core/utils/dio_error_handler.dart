import 'dart:io';

import 'package:app/core/exceptions/app_exceptions.dart';
import 'package:dio/dio.dart';

import '../constants/app_failure_messages.dart';

class DioErrorHandler {
  static AppException handle({required DioError dioError,
    String unAuthorizedErrorMessage = AppFailureMessages.kUnauthorized}) {
    switch (dioError.type) {
      case DioErrorType.badResponse:
        return _errorResponseHandler(dioError.response!,
            unAuthorizedErrorMessage: unAuthorizedErrorMessage);

      case DioErrorType.cancel:
        return AppException.unknownException(
            message: AppFailureMessages.kUnknownError);

      case DioErrorType.connectionTimeout:
      case DioErrorType.receiveTimeout:
      case DioErrorType.sendTimeout:
        return AppException.timeOutException(
            message: AppFailureMessages.kTimeOut);

      case DioErrorType.unknown:
      default:
        return AppException.unknownException(
            message: AppFailureMessages.kUnknownError);
    }
  }

  static _errorResponseHandler(Response response,
      {required String unAuthorizedErrorMessage}) {
    switch (response.statusCode) {
      case HttpStatus
          .badRequest: // When form data is not invalid and request is sent
        try {
          final errorMessage = response.data['message'];
          return AppException.badRequest(message: errorMessage.toString());
        } catch (_) {}

        return AppException.badRequest(message: AppFailureMessages.kBadRequest);

      case HttpStatus.unauthorized: // User session expired
        return AppException.unAuthorized(message: unAuthorizedErrorMessage);

      case HttpStatus.forbidden: // User does not have enough access
        return AppException.forbidden(message: AppFailureMessages.kForbidden);

      case HttpStatus
          .unprocessableEntity: // When form data is valid but request cannot be processed
        try {
          final Map<String, dynamic> errors = response.data['errors'];

          if (errors.isNotEmpty) {
            List<dynamic> firstError = errors.entries.first.value;

            if (firstError.isNotEmpty) {
              return AppException.unProcessableEntity(
                  message: firstError.first.toString());
            }
          }
        } catch (_) {}

        return AppException.unProcessableEntity(
            message: AppFailureMessages.kUnProcessableEntity);

      case HttpStatus.notFound:
        return AppException.notFoundException(
            message: AppFailureMessages.kNotFound);

      case HttpStatus.internalServerError:
      default:
        return AppException.internalServerException(
            message: AppFailureMessages.kInternalServerError);
    }
  }
}
