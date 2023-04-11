import 'package:dartz/dartz.dart';

import '../../domain/entities/login__response_detail/login_response_detail.dart';
import '../../domain/entities/register_response_detail/register_response_detail.dart';

abstract class AuthRemoteDataSource {
  // Future<UserModel> signInWithGoogle();
  //
  // Future<UserModel> signInWithApple();
  //
  // Future<UserModel> signInWithFacebook();
  //
  // Future<UserModel> signInWithFirebase(
  //     {required String firebaseIdToken, String? email, String? displayName});

  Future<LoginResponseDetail> signInWithCredentials(
      {required String username, required String password});

  Future<RegisterResponseDetail> registerNewUser({
    required String username,
    // required String fullName,
    required String password,
  });

  Future<Unit> resetPassword({
    required String email,
  });

  Future<Unit> deleteAccount();
}
