part of 'reset_password_bloc.dart';

@freezed
class ResetPasswordEvent with _$ResetPasswordEvent {
  factory ResetPasswordEvent.sendLinkPressed() =
      _ResetPasswordEventSendLinkPressed;
  factory ResetPasswordEvent.emailChanged({required String email}) =
      _ResetPasswordEventEmailChanged;
}
