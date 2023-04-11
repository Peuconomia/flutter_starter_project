import 'package:app/core/failures/app_failures.dart';
import 'package:app/core/use_cases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/no_params.dart';
import '../entities/login_detail/login_detail.dart';
import '../repositories/auth.dart';

@lazySingleton
class GetSavedLoginDetailUseCase
    extends UseCase<AppFailure, LoginDetail?, NoParams> {
  final AuthRepository repository;

  GetSavedLoginDetailUseCase({
    required this.repository,
  });

  @override
  Future<Either<AppFailure, LoginDetail?>> call(NoParams params) async {
    return await repository.getSavedLoginDetail();
  }
}
