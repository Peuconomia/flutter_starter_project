import 'package:dartz/dartz.dart';

import '../../domain/entities/login_detail/login_detail.dart';
import '../models/user.dart';

abstract class AuthLocalDataSource {
  Future<bool> hasLocalSavedUser();

  Future<UserModel?> getCurrentUser();

  Future<Unit> saveUser({required UserModel user});

  Future<Unit> signOut();

  Future<LoginDetail?> getSavedLoginDetail();

  Future<Unit> saveLoginDetail({required LoginDetail detail});

  Future<Unit> removeSavedLoginDetail();
}
