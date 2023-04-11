import 'package:app/core/exceptions/app_exceptions.dart';
import 'package:app/core/failures/app_failures.dart';
import 'package:app/features/auth/data/datasources/auth_local.dart';
import 'package:app/features/auth/domain/repositories/auth.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/app_failure_messages.dart';
import '../../constants/user_status.dart';
import '../../domain/entities/login__response_detail/login_response_detail.dart';
import '../../domain/entities/login_detail/login_detail.dart';
import '../../domain/entities/register_response_detail/register_response_detail.dart';
import '../datasources/auth_remote.dart';
import '../models/user.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthLocalDataSource localDataSource;
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<AppFailure, RegisterResponseDetail>> registerNewUser({
    required String username,
    // required String fullName,
    required String password,
  }) async {
    try {
      final detail = await remoteDataSource.registerNewUser(
          username: username, password: password);

      if (detail.userDetail.userStatus == UserStatus.kApproved) {
        final user = UserModel(
          idToken: detail.token,
          refreshToken: '',
          fcmToken: await FirebaseMessaging.instance.getToken() ?? '',
        );

        // Save the user
        final _ = await localDataSource.saveUser(user: user);
      }

      return Right(detail);
    } on AppException catch (e) {
      return Left(AppFailure.fromException(e));
    }
  }

  // @override
  // Future<Either<AppFailure, Unit>> signInWithApple() async {
  //   try {
  //     // try login with facebook
  //     final UserModel user = await remoteDataSource.signInWithApple();
  //
  //     // Save the user
  //     final result = await localDataSource.saveUser(user: user);
  //
  //     return Right(result);
  //   } on AppException catch (exception) {
  //     return Left(AppFailure.fromException(exception));
  //   } catch (e) {
  //     return Left(
  //         AppFailure.unknownFailure(message: AppFailureMessages.kUnknownError));
  //   }
  // }

  @override
  Future<Either<AppFailure, LoginResponseDetail>> signInWithCredentials(
      {required String username, required String password}) async {
    try {
      // try login with credentials

      final detail = await remoteDataSource.signInWithCredentials(
          username: username, password: password);

      if (detail.userDetail.userStatus == UserStatus.kApproved) {
        final user = UserModel(
          idToken: detail.token,
          refreshToken: '',
          fcmToken: await FirebaseMessaging.instance.getToken() ?? '',
        );

        // Save the user
        final _ = await localDataSource.saveUser(user: user);
      }

      return Right(detail);
    } on AppException catch (exception) {
      return Left(AppFailure.fromException(exception));
    } catch (e) {
      return Left(
          AppFailure.unknownFailure(message: AppFailureMessages.kUnknownError));
    }
  }

  // @override
  // Future<Either<AppFailure, Unit>> signInWithFacebook() async {
  //   try {
  //     // try login with facebook
  //     final UserModel user = await remoteDataSource.signInWithFacebook();
  //
  //     // Save the user
  //     final result = await localDataSource.saveUser(user: user);
  //
  //     return Right(result);
  //   } on AppException catch (exception) {
  //     return Left(AppFailure.fromException(exception));
  //   } catch (e) {
  //     return Left(
  //         AppFailure.unknownFailure(message: AppFailureMessages.kUnknownError));
  //   }
  // }
  //
  // @override
  // Future<Either<AppFailure, Unit>> signInWithGoogle() async {
  //   try {
  //     // try login with google
  //     final UserModel user = await remoteDataSource.signInWithGoogle();
  //
  //     // Save the user
  //     final result = await localDataSource.saveUser(user: user);
  //
  //     return Right(result);
  //   } on AppException catch (exception) {
  //     return Left(AppFailure.fromException(exception));
  //   } catch (e) {
  //     return Left(
  //         AppFailure.unknownFailure(message: AppFailureMessages.kUnknownError));
  //   }
  // }

  @override
  Future<Either<AppFailure, Unit>> signOut() async {
    try {
      await localDataSource.signOut();

      return const Right(unit);
    } catch (e) {
      return Left(
          AppFailure.unknownFailure(message: AppFailureMessages.kUnknownError));
    }
  }

  @override
  Future<Either<AppFailure, Unit>> resetPassword(
      {required String email}) async {
    try {
      await remoteDataSource.resetPassword(email: email);

      return const Right(unit);
    } on AppException catch (exception) {
      return Left(AppFailure.fromException(exception));
    } catch (e) {
      return Left(
          AppFailure.unknownFailure(message: AppFailureMessages.kUnknownError));
    }
  }

  @override
  Future<Either<AppFailure, LoginDetail?>> getSavedLoginDetail() async {
    try {
      final loginDetail = await localDataSource.getSavedLoginDetail();

      return Right(loginDetail);
    } on AppException catch (exception) {
      return Left(AppFailure.fromException(exception));
    } catch (e) {
      return Left(
          AppFailure.unknownFailure(message: AppFailureMessages.kUnknownError));
    }
  }

  @override
  Future<Either<AppFailure, Unit>> saveLoginDetail(
      {required LoginDetail detail}) async {
    try {
      await localDataSource.saveLoginDetail(detail: detail);

      return const Right(unit);
    } on AppException catch (exception) {
      return Left(AppFailure.fromException(exception));
    } catch (e) {
      return Left(
          AppFailure.unknownFailure(message: AppFailureMessages.kUnknownError));
    }
  }

  @override
  Future<Either<AppFailure, Unit>> removeSavedLoginDetail() async {
    try {
      await localDataSource.removeSavedLoginDetail();

      return const Right(unit);
    } on AppException catch (exception) {
      return Left(AppFailure.fromException(exception));
    } catch (e) {
      return Left(
          AppFailure.unknownFailure(message: AppFailureMessages.kUnknownError));
    }
  }

  @override
  Future<Either<AppFailure, Unit>> deleteAccount() async {
    try {
      await remoteDataSource.deleteAccount();

      await localDataSource.signOut();

      return const Right(unit);
    } on AppException catch (exception) {
      return Left(AppFailure.fromException(exception));
    } catch (e) {
      return Left(
          AppFailure.unknownFailure(message: AppFailureMessages.kUnknownError));
    }
  }
}
