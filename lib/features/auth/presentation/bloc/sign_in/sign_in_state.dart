part of 'sign_in_bloc.dart';

@freezed
class SignInState with _$SignInState {
  factory SignInState.initial() = _SignInStateInitial;

  factory SignInState.initializing() = _SignInStateInitializing;

  factory SignInState.initialized({LoginDetail? detail}) =
      _SignInStateInitialized;

  factory SignInState.initializationFailed() = _SignInStateInitializationFailed;

  factory SignInState.loginStarting() = _SignInStateStarting;

  factory SignInState.loginFailure({required AppFailure failure}) =
      _SignInStateFailure;

  factory SignInState.loginSuccess({required LoginResponseDetail detail}) =
      _SignInStateSuccess;
}
