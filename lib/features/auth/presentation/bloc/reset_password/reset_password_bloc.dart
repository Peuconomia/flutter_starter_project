import 'package:app/core/failures/app_failures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/usecases/send_reset_password_link.dart';

part 'reset_password_bloc.freezed.dart';
part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  String email = '';

  final SendResetPasswordLinkUseCase sendResetPasswordLinkUseCase;

  ResetPasswordBloc({
    required this.sendResetPasswordLinkUseCase,
  }) : super(ResetPasswordState.initial()) {
    on<_ResetPasswordEventSendLinkPressed>(
        _onResetPasswordEventSendLinkPressed);
    on<_ResetPasswordEventEmailChanged>(_onResetPasswordEventEmailChanged);
  }

  void _onResetPasswordEventSendLinkPressed(
      _ResetPasswordEventSendLinkPressed event,
      Emitter<ResetPasswordState> emit) async {
    emit(ResetPasswordState.sendingLink());

    final result = await sendResetPasswordLinkUseCase(
        ResetPasswordLinkParams(email: email));

    result.fold((failure) {
      emit(ResetPasswordState.linkSendFailed(failure: failure));
    }, (_) {
      emit(ResetPasswordState.linkSent());
    });
  }

  void _onResetPasswordEventEmailChanged(
      _ResetPasswordEventEmailChanged event, Emitter<ResetPasswordState> emit) {
    email = event.email;
  }
}
