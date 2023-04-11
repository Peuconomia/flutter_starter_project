import 'dart:convert';
import 'dart:math';

import 'package:app/core/utils/dio_error_handler.dart';
import 'package:app/features/auth/constants/constants.dart';
import 'package:app/features/auth/data/datasources/auth_remote.dart';
import 'package:app/features/auth/domain/entities/login__response_detail/login_response_detail.dart';
import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/app_failure_messages.dart';
import '../../../../core/exceptions/app_exceptions.dart';
import '../../domain/entities/register_response_detail/register_response_detail.dart';

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<RegisterResponseDetail> registerNewUser(
      {required String username,
      // required String fullName,
      required String password}) async {
    Response response;

    try {
      response = await dio.post(AuthApiEndpoints.registerUser, data: {
        // 'name': fullName,
        'email': username,
        'password': password,
      });

      // UserModel user = UserModel(
      //   idToken: response.data['token'],
      //   fcmToken: await FirebaseMessaging.instance.getToken() ?? '',
      //   refreshToken: '',
      // );

      RegisterResponseDetail detail =
          RegisterResponseDetail.fromJson(response.data);

      return detail;
    } on DioError catch (error) {
      throw DioErrorHandler.handle(dioError: error);
    } catch (e, stack) {
      await FirebaseCrashlytics.instance.recordError(e, stack);
      throw AppException.unknownException(
          message: AppFailureMessages.kUnknownError);
    }
  }

  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  // @override
  // Future<UserModel> signInWithApple() async {
  //   // To prevent replay attacks with the credential returned from Apple, we
  //   // include a nonce in the credential request. When signing in with
  //   // Firebase, the nonce in the id token returned by Apple, is expected to
  //   // match the sha256 hash of `rawNonce`.
  //   final rawNonce = _generateNonce();
  //   final nonce = _sha256ofString(rawNonce);
  //
  //   try {
  //     // Request credential for the currently signed in Apple account.
  //     final appleCredential = await SignInWithApple.getAppleIDCredential(
  //       scopes: [
  //         AppleIDAuthorizationScopes.email,
  //         AppleIDAuthorizationScopes.fullName,
  //       ],
  //       nonce: nonce,
  //     );
  //
  //     // Create an `OAuthCredential` from the credential returned by Apple.
  //     final appleOauthProvider = OAuthProvider(
  //       "apple.com",
  //     );
  //
  //     appleOauthProvider.setScopes([
  //       'email',
  //       'name',
  //     ]);
  //
  //     final oauthCredential = appleOauthProvider.credential(
  //       idToken: appleCredential.identityToken,
  //       rawNonce: rawNonce,
  //     );
  //
  //     // Sign in the user with Firebase. If the nonce we generated earlier does
  //     // not match the nonce in `appleCredential.identityToken`, sign in will fail.
  //     final userCredential = await FirebaseAuth.instance.signInWithCredential(
  //       oauthCredential,
  //     );
  //
  //     if (userCredential.user != null) {
  //       if (userCredential.user?.email == null &&
  //           appleCredential.email != null) {
  //         await userCredential.user?.updateEmail(appleCredential.email!);
  //       }
  //
  //       if (userCredential.user?.displayName == null &&
  //           appleCredential.givenName != null &&
  //           appleCredential.familyName != null) {
  //         await userCredential.user?.updateDisplayName(
  //             '${appleCredential.givenName} ${appleCredential.familyName}');
  //       }
  //     }
  //
  //     final firebaseIdToken = await userCredential.user?.getIdToken();
  //
  //     if (firebaseIdToken != null) {
  //       return await signInWithFirebase(firebaseIdToken: firebaseIdToken);
  //     } else {
  //       throw AppException.unAuthorized(
  //           message: AppFailureMessages.kFailedToSignInWithGoogle);
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     throw _firebaseAuthExceptionHandler(
  //         authException: e,
  //         defaultUnauthorizedMessage:
  //             AppFailureMessages.kFailedToSignInWithApple);
  //   } on DioError catch (error) {
  //     throw DioErrorHandler.handle(
  //         dioError: error,
  //         unAuthorizedErrorMessage:
  //             AppFailureMessages.kUsernameOrPasswordInvalid);
  //   } on AppException catch (_) {
  //     rethrow;
  //   } catch (e, stack) {
  //     await FirebaseCrashlytics.instance.recordError(e, stack);
  //     throw AppException.unknownException(
  //         message: AppFailureMessages.kUnknownError);
  //   }
  // }

  @override
  Future<LoginResponseDetail> signInWithCredentials(
      {required String username, required String password}) async {
    try {
      final response =
          await dio.post(AuthApiEndpoints.loginWithCredentials, data: {
        'login': username,
        'password': password,
      });

      // final model = UserModel(
      //   idToken: response.data['token'],
      //   refreshToken: '',
      //   fcmToken: await FirebaseMessaging.instance.getToken() ?? '',
      // );

      LoginResponseDetail detail = LoginResponseDetail.fromJson(response.data);

      return detail;
    } on DioError catch (error) {
      throw DioErrorHandler.handle(
          dioError: error,
          unAuthorizedErrorMessage:
              AppFailureMessages.kUsernameOrPasswordInvalid);
    } catch (e, stack) {
      await FirebaseCrashlytics.instance.recordError(e, stack);
      throw AppException.unknownException(
          message: AppFailureMessages.kUnknownError);
    }
  }

  // @override
  // Future<UserModel> signInWithFacebook() async {
  //   final LoginResult loginResult;
  //
  //   try {
  //     // Trigger the sign-in flow
  //     loginResult = await FacebookAuth.instance.login();
  //   } catch (e) {
  //     throw AppException.unAuthorized(
  //         message: AppFailureMessages.kFailedToSignInWithFacebook);
  //   }
  //
  //   if (loginResult.status == LoginStatus.success) {
  //     // Create a credential from the access token
  //     final OAuthCredential facebookAuthCredential =
  //         FacebookAuthProvider.credential(loginResult.accessToken!.token);
  //
  //     try {
  //       // Once signed in, return the UserCredential
  //       final firebaseUser = await FirebaseAuth.instance
  //           .signInWithCredential(facebookAuthCredential);
  //
  //       final firebaseIdToken = await firebaseUser.user?.getIdToken();
  //
  //       if (firebaseIdToken != null) {
  //         return await signInWithFirebase(firebaseIdToken: firebaseIdToken);
  //       } else {
  //         throw AppException.unAuthorized(
  //             message: AppFailureMessages.kFailedToSignInWithFacebook);
  //       }
  //     } on FirebaseAuthException catch (e) {
  //       throw _firebaseAuthExceptionHandler(
  //           authException: e,
  //           defaultUnauthorizedMessage:
  //               AppFailureMessages.kFailedToSignInWithFacebook);
  //     } catch (e) {
  //       throw AppException.unAuthorized(
  //           message: AppFailureMessages.kFailedToSignInWithFacebook);
  //     }
  //   } else {
  //     throw AppException.unAuthorized(
  //         message: AppFailureMessages.kFailedToSignInWithFacebook);
  //   }
  // }
  //
  // @override
  // Future<UserModel> signInWithGoogle() async {
  //   final GoogleSignIn googleSignIn = GoogleSignIn();
  //
  //   GoogleSignInAccount? googleUser;
  //
  //   try {
  //     googleUser = await googleSignIn.signIn();
  //   } catch (e) {
  //     throw AppException.unAuthorized(
  //         message: AppFailureMessages.kFailedToSignInWithGoogle);
  //   }
  //
  //   // User is logged in
  //   if (googleUser != null) {
  //     // Obtain the auth details from the request
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;
  //
  //     final credential = GoogleAuthProvider.credential(
  //       idToken: googleAuth.idToken,
  //       accessToken: googleAuth.accessToken,
  //     );
  //
  //     // Once signed in, get the UserCredential
  //     try {
  //       final firebaseUser =
  //           await FirebaseAuth.instance.signInWithCredential(credential);
  //
  //       final firebaseIdToken = await firebaseUser.user?.getIdToken();
  //
  //       if (firebaseIdToken != null) {
  //         return await signInWithFirebase(firebaseIdToken: firebaseIdToken);
  //       } else {
  //         throw AppException.unAuthorized(
  //             message: AppFailureMessages.kFailedToSignInWithGoogle);
  //       }
  //     } on FirebaseAuthException catch (e) {
  //       throw _firebaseAuthExceptionHandler(
  //           authException: e,
  //           defaultUnauthorizedMessage:
  //               AppFailureMessages.kFailedToSignInWithGoogle);
  //     } catch (e) {
  //       throw AppException.unAuthorized(
  //           message: AppFailureMessages.kFailedToSignInWithGoogle);
  //     }
  //   } else {
  //     // User failed to login
  //     throw AppException.unAuthorized(
  //         message: AppFailureMessages.kFailedToSignInWithGoogle);
  //   }
  // }

  @override
  Future<Unit> resetPassword({required String email}) async {
    try {
      await dio.post(AuthApiEndpoints.resetPassword, data: {'email': email});

      return unit;
    } on DioError catch (error) {
      throw DioErrorHandler.handle(dioError: error);
    } catch (e, stack) {
      await FirebaseCrashlytics.instance.recordError(e, stack);
      throw AppException.internalServerException(
          message: AppFailureMessages.kInternalServerError);
    }
  }

  @override
  Future<Unit> deleteAccount() async {
    try {
      await dio.post(AuthApiEndpoints.deleteAccount);

      return unit;
    } on DioError catch (error) {
      throw DioErrorHandler.handle(dioError: error);
    } catch (e, stack) {
      await FirebaseCrashlytics.instance.recordError(e, stack);
      throw AppException.internalServerException(
          message: AppFailureMessages.kInternalServerError);
    }
  }

//   @override
//   Future<UserModel> signInWithFirebase(
//       {required String firebaseIdToken,
//       String? email,
//       String? displayName}) async {
//     try {
//       final response = await dio.post(
//         AuthApiEndpoints.loginWithFirebase,
//         data: {
//           'idToken': firebaseIdToken,
//         },
//       );
//
//       final model = UserModel(
//         idToken: response.data['token'],
//         refreshToken: '',
//         fcmToken: await FirebaseMessaging.instance.getToken() ?? '',
//       );
//
//       return model;
//     } on DioError catch (error) {
//       throw DioErrorHandler.handle(dioError: error);
//     } catch (e, stack) {
//       await FirebaseCrashlytics.instance.recordError(e, stack);
//       throw AppException.internalServerException(
//           message: AppFailureMessages.kInternalServerError);
//     }
//   }
}

// AppException _firebaseAuthExceptionHandler(
//     {required FirebaseAuthException authException,
//     required String defaultUnauthorizedMessage}) {
//   switch (authException.code) {
//     case 'email-already-in-use':
//       return AppException.unAuthorized(
//           message: AppFailureMessages.kEmailAlreadyInUse);
//
//     case 'account-exists-with-different-credential':
//       return AppException.unAuthorized(
//           message: AppFailureMessages.kAccountExistsWithDifferentCredentials);
//     case 'user-disabled':
//       return AppException.unAuthorized(
//           message: AppFailureMessages.kUserDisabled);
//
//     case 'provider-already-linked':
//       return AppException.unAuthorized(
//           message: AppFailureMessages.kProviderAlreadyLinked);
//
//     case 'credential-already-in-use':
//       return AppException.unAuthorized(
//           message: AppFailureMessages.kProviderAlreadyInUse);
//
//     case "invalid-credential":
//       return AppException.unAuthorized(
//           message: AppFailureMessages.kProviderAlreadyLinked);
//
//     default:
//       return AppException.unAuthorized(message: defaultUnauthorizedMessage);
//   }
// }
