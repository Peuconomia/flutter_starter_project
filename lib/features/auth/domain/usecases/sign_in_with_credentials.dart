import 'package:app/core/failures/app_failures.dart';
import 'package:app/core/use_cases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../core/constants/app_failure_messages.dart';
import '../entities/login__response_detail/login_response_detail.dart';
import '../repositories/auth.dart';

@lazySingleton
class SignInWithCredentialsUseCase
    extends UseCase<AppFailure, LoginResponseDetail, LoginParams> {
  final AuthRepository repository;
  final InternetConnectionChecker connectionChecker;

  SignInWithCredentialsUseCase(
      {required this.repository, required this.connectionChecker});

  @override
  Future<Either<AppFailure, LoginResponseDetail>> call(
      LoginParams params) async {
    final isConnected = await connectionChecker.hasConnection;

    if (!isConnected) {
      return Left(AppFailure.noInternetConnection(
          message: AppFailureMessages.kNoInternet));
    }

    return await repository.signInWithCredentials(
        username: params.username, password: params.password);
  }
}

class LoginParams {
  final String username;
  final String password;
  final bool rememberCredentials;

  LoginParams({
    required this.username,
    required this.password,
    required this.rememberCredentials,
  });
}
