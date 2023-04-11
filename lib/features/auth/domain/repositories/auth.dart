import 'package:dartz/dartz.dart';

import '../../../../core/failures/app_failures.dart';
import '../entities/login__response_detail/login_response_detail.dart';
import '../entities/login_detail/login_detail.dart';
import '../entities/register_response_detail/register_response_detail.dart';

abstract class AuthRepository {
  // Future<Either<AppFailure, Unit>> signInWithGoogle();
  //
  // Future<Either<AppFailure, Unit>> signInWithApple();
  //
  // Future<Either<AppFailure, Unit>> signInWithFacebook();

  Future<Either<AppFailure, LoginResponseDetail>> signInWithCredentials({
    required String username,
    required String password,
  });

  Future<Either<AppFailure, Unit>> signOut();

  Future<Either<AppFailure, RegisterResponseDetail>> registerNewUser({
    required String username,
    // required String fullName,
    required String password,
  });

  Future<Either<AppFailure, Unit>> resetPassword({required String email});

  Future<Either<AppFailure, LoginDetail?>> getSavedLoginDetail();

  Future<Either<AppFailure, Unit>> saveLoginDetail(
      {required LoginDetail detail});

  Future<Either<AppFailure, Unit>> removeSavedLoginDetail();

  Future<Either<AppFailure, Unit>> deleteAccount();
}
