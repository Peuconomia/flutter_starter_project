import 'package:app/core/failures/app_failures.dart';
import 'package:app/core/use_cases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../repositories/auth.dart';

@lazySingleton
class RegisterNewUserUseCase extends UseCase<AppFailure, Unit, NewUserParams> {
  final AuthRepository repository;
  final InternetConnectionChecker connectionChecker;

  RegisterNewUserUseCase(
      {required this.repository, required this.connectionChecker});

  @override
  Future<Either<AppFailure, Unit>> call(NewUserParams params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}

class NewUserParams {
  final String username;
  final String fullName;
  final String password;

  NewUserParams({
    required this.username,
    required this.fullName,
    required this.password,
  });
}
