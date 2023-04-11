part of 'sign_up_bloc.dart';

@freezed
class SignUpState with _$SignUpState {
  factory SignUpState.initial() = _SignUpStateInitial;

  factory SignUpState.registeringUser() = _SignUpStateRegisteringUser;

  factory SignUpState.registerFailed({required FailureDetail detail}) =
      _SignUpStateRegisterFailed;

  factory SignUpState.registerSuccess(
          {required RegisterResponseDetail registerResponseDetail}) =
      _SignUpStateRegisterSuccess;
}
