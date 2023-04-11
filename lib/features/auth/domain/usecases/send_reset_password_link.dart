import 'package:app/core/failures/app_failures.dart';
import 'package:app/core/use_cases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../core/constants/app_failure_messages.dart';
import '../repositories/auth.dart';

@lazySingleton
class SendResetPasswordLinkUseCase
    extends UseCase<AppFailure, Unit, ResetPasswordLinkParams> {
  final AuthRepository repository;
  final InternetConnectionChecker connectionChecker;

  SendResetPasswordLinkUseCase({
    required this.repository,
    required this.connectionChecker,
  });
  @override
  Future<Either<AppFailure, Unit>> call(ResetPasswordLinkParams params) async {
    final isConnected = await connectionChecker.hasConnection;

    if (!isConnected) {
      return Left(AppFailure.noInternetConnection(
          message: AppFailureMessages.kNoInternet));
    }

    return await repository.resetPassword(
      email: params.email,
    );
  }
}

class ResetPasswordLinkParams {
  final String email;

  const ResetPasswordLinkParams({
    required this.email,
  });
}
