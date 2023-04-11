import 'dart:io';

import 'package:app/core/constants/app_failure_messages.dart';
import 'package:app/core/exceptions/app_exceptions.dart';
import 'package:dio/dio.dart';

/// Throws [AppException] in case of status code not being 200-299.
class ApiResponseHandler {
  static T handleResponse<T>(
    Response response, {
    required T Function(dynamic data) onSuccess,
    required AppException Function(dynamic data) onBadRequest,
    required AppException Function(dynamic data) onUnProcessableEntity,
  }) {
    switch (response.statusCode) {
      case HttpStatus.ok:
      case HttpStatus.accepted:
        return onSuccess(response.data);

      case HttpStatus
          .badRequest: // When form data is not invalid and request is sent
        throw onBadRequest(response.data);

      case HttpStatus.unauthorized: // User session expired
        throw AppException.unAuthorized(
            message: AppFailureMessages.kUnauthorized);

      case HttpStatus.forbidden: // User does not have enough access
        throw AppException.forbidden(message: AppFailureMessages.kForbidden);

      case HttpStatus
          .unprocessableEntity: // When form data is valid but request cannot be processed
        throw onUnProcessableEntity(response.data);

      case HttpStatus.internalServerError:
        throw AppException.internalServerException(
            message: AppFailureMessages.kInternalServerError);

      default:
        throw AppException.unknownException(
            message: AppFailureMessages.kUnknownError);
    }
  }
}
