import 'package:app/core/exceptions/app_exceptions.dart';
import 'package:app/features/auth/data/datasources/auth_local.dart';
import 'package:app/features/auth/data/models/user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/config_reader/app_config_reader.dart';
import '../../../../core/constants/app_failure_messages.dart';
import '../../domain/entities/login_detail/login_detail.dart';

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  final FlutterSecureStorage secureStorage;
  final AppConfigReader appConfigReader;

  AuthLocalDataSourceImpl({
    required this.secureStorage,
    required this.appConfigReader,
  });

  @override
  Future<bool> hasLocalSavedUser() async {
    final config = await appConfigReader.getConfig();
    return config.user != null;
  }

  @override
  Future<Unit> saveUser({required UserModel user}) async {
    try {
      final config = await appConfigReader.getConfig();
      await appConfigReader.saveConfig(config.copyWith(user: user));
    } on PlatformException catch (_) {
      throw AppException.cacheException(
          message: AppFailureMessages.kFailedToSaveUserLocally);
    }

    return unit;
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final config = await appConfigReader.getConfig();

    return config.user;
  }

  @override
  Future<Unit> signOut() async {
    //Sign out by removing local user
    final config = await appConfigReader.getConfig();
    await appConfigReader.saveConfig(config.copyWith(user: null));

    // Sign out from social login providers
    // await GoogleSignIn().signOut();
    // await FacebookAuth.instance.logOut();
    //
    // // sign out from firebase auth
    // FirebaseAuth auth = FirebaseAuth.instance;
    // await auth.signOut();

    return unit;
  }

  @override
  Future<LoginDetail?> getSavedLoginDetail() async {
    try {
      final config = await appConfigReader.getConfig();
      return config.savedCredentials;
    } catch (e) {
      throw AppException.cacheException(
          message: AppFailureMessages.kCacheException);
    }
  }

  @override
  Future<Unit> saveLoginDetail({required LoginDetail detail}) async {
    try {
      final config = await appConfigReader.getConfig();
      await appConfigReader
          .saveConfig(config.copyWith(savedCredentials: detail));

      return unit;
    } catch (e) {
      throw AppException.cacheException(
          message: AppFailureMessages.kCacheException);
    }
  }

  @override
  Future<Unit> removeSavedLoginDetail() async {
    try {
      final config = await appConfigReader.getConfig();
      await appConfigReader.saveConfig(config.copyWith(savedCredentials: null));

      return unit;
    } catch (e) {
      throw AppException.cacheException(
          message: AppFailureMessages.kCacheException);
    }
  }
}
