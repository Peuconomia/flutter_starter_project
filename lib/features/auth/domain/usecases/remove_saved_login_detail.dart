import 'package:app/core/failures/app_failures.dart';
import 'package:app/core/use_cases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/no_params.dart';
import '../repositories/auth.dart';

@lazySingleton
class RemoveSavedLoginDetailUseCase
    extends UseCase<AppFailure, Unit, NoParams> {
  final AuthRepository repository;

  RemoveSavedLoginDetailUseCase({
    required this.repository,
  });

  @override
  Future<Either<AppFailure, Unit>> call(NoParams params) async {
    return await repository.removeSavedLoginDetail();
  }
}
