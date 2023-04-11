part of 'sign_in_bloc.dart';

@freezed
class SignInEvent with _$SignInEvent {
  factory SignInEvent.initializeTriggered() =
  _InitializeTriggered;


  factory SignInEvent.usernameChanged({
    required String username,
  }) = _SignInUsernameChanged;

  factory SignInEvent.passwordChanged({
    required String password,
  }) = _SignInPasswordChanged;

  factory SignInEvent.rememberMeChanged({
    required bool rememberMe,
  }) = _SignInRememberMeChanged;

  factory SignInEvent.signInWithCredentialsPressed() =
  _SignInWithCredentialsPressed;

  factory SignInEvent.signInWithGmailPressed() = _SignInWithGmailPressed;

  factory SignInEvent.signInWithApplePressed() = _SignInWithApplePressed;

  factory SignInEvent.signInWithFacebookPressed() = _SignInWithFacebookPressed;
}
