import 'package:app/core/failures/app_failures.dart';
import 'package:app/core/use_cases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../entities/login_detail/login_detail.dart';
import '../repositories/auth.dart';

@lazySingleton
class SaveLoginDetailUseCase
    extends UseCase<AppFailure, Unit, SaveLoginDetailParams> {
  final AuthRepository repository;

  SaveLoginDetailUseCase({
    required this.repository,
  });

  @override
  Future<Either<AppFailure, Unit>> call(SaveLoginDetailParams params) async {
    return await repository.saveLoginDetail(detail: params.detail);
  }
}

class SaveLoginDetailParams {
  final LoginDetail detail;

  SaveLoginDetailParams({required this.detail});
}
