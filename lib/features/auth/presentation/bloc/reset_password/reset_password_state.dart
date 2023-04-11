part of 'reset_password_bloc.dart';

@freezed
class ResetPasswordState with _$ResetPasswordState {
  factory ResetPasswordState.initial() = _ResetPasswordStateInitial;
  factory ResetPasswordState.sendingLink() = _ResetPasswordStateSendingLink;
  factory ResetPasswordState.linkSent() = _ResetPasswordStateLinkSent;
  factory ResetPasswordState.linkSendFailed({required AppFailure failure}) =
      _ResetPasswordStateLinkSendFailed;
}
