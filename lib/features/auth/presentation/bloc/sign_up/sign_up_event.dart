part of 'sign_up_bloc.dart';

@freezed
class SignUpEvent with _$SignUpEvent {
  factory SignUpEvent.signUpPressed({
    required String fullName,
    required String email,
    required String password,
  }) = _SignUpPressed;

  factory SignUpEvent.emailChanged({
    required String email,
  }) = _SignUpEmailChanged;

  factory SignUpEvent.fullNameChanged({
    required String fullName,
  }) = _SignUpFullNameChanged;

  factory SignUpEvent.passwordChanged({
    required String password,
  }) = _SignUpPasswordChanged;

  factory SignUpEvent.hasUserAgreedChanged({
    required bool hasUserAgreed,
  }) = _SignUpHasUserAgreedChanged;
}
