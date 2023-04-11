import 'package:app/core/failures/app_failures.dart';
import 'package:app/core/use_cases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../core/constants/app_failure_messages.dart';
import '../entities/register_response_detail/register_response_detail.dart';
import '../repositories/auth.dart';

@lazySingleton
class SignUpWithDetailsUseCase
    extends UseCase<AppFailure, RegisterResponseDetail, UserRegisterParams> {
  final AuthRepository repository;
  final InternetConnectionChecker connectionChecker;

  SignUpWithDetailsUseCase({
    required this.repository,
    required this.connectionChecker,
  });

  @override
  Future<Either<AppFailure, RegisterResponseDetail>> call(
      UserRegisterParams params) async {
    final isConnected = await connectionChecker.hasConnection;

    if (!isConnected) {
      return Left(AppFailure.noInternetConnection(
          message: AppFailureMessages.kNoInternet));
    }

    return await repository.registerNewUser(
      username: params.email,
      // fullName: params.fullName,
      password: params.password,
    );
  }
}

class UserRegisterParams {
  final String email;
  final String password;

  // final String fullName;

  const UserRegisterParams({
    required this.email,
    required this.password,
    // required this.fullName,
  });
}
