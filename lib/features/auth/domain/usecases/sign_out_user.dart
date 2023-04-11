import 'package:app/core/entities/no_params.dart';
import 'package:app/core/failures/app_failures.dart';
import 'package:app/core/use_cases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/auth.dart';

@lazySingleton
class SignOutUserUseCase extends UseCase<AppFailure, Unit, NoParams> {
  final AuthRepository repository;

  SignOutUserUseCase({required this.repository});

  @override
  Future<Either<AppFailure, Unit>> call(NoParams params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
