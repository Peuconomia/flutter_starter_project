import 'package:app/core/failures/app_failures.dart';
import 'package:app/core/use_cases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../core/constants/app_failure_messages.dart';
import '../../../../core/entities/no_params.dart';
import '../repositories/auth.dart';

@lazySingleton
class DeleteUserUseCase extends UseCase<AppFailure, Unit, NoParams> {
  final AuthRepository repository;
  final InternetConnectionChecker connectionChecker;

  DeleteUserUseCase({
    required this.repository,
    required this.connectionChecker,
  });

  @override
  Future<Either<AppFailure, Unit>> call(NoParams params) async {
    final isConnected = await connectionChecker.hasConnection;

    if (!isConnected) {
      return Left(AppFailure.noInternetConnection(
          message: AppFailureMessages.kNoInternet));
    }

    return await repository.deleteAccount();
  }
}
