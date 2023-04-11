import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String idToken;
  final String refreshToken;
  final String fcmToken;

  const User({
    required this.idToken,
    required this.refreshToken,
    required this.fcmToken,
  });

  @override
  List<Object?> get props => [idToken, refreshToken, fcmToken];
}
