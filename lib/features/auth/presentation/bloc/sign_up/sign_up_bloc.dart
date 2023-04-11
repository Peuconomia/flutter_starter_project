import 'package:app/core/entities/failure_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/register_detail.dart';
import '../../../domain/entities/register_response_detail/register_response_detail.dart';
import '../../../domain/usecases/sign_up_with_details.dart';

part 'sign_up_bloc.freezed.dart';
part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpWithDetailsUseCase signUpWithDetailsUseCase;

  RegisterDetail detail;

  SignUpBloc(
      {required this.signUpWithDetailsUseCase,
      this.detail = const RegisterDetail()})
      : super(SignUpState.initial()) {
    on<_SignUpPressed>(_onSignUpPressed);
    on<_SignUpEmailChanged>(_onSignUpEmailChanged);
    on<_SignUpFullNameChanged>(_onSignUpFullNameChanged);
    on<_SignUpPasswordChanged>(_onSignUpPasswordChanged);
    on<_SignUpHasUserAgreedChanged>(_onSignUpHasUserAgreedChanged);
  }

  void _onSignUpPressed(_SignUpPressed event, Emitter<SignUpState> emit) async {
    emit(SignUpState.registeringUser());

    if (!detail.hasUserAgreed) {
      emit(SignUpState.registerFailed(
          detail: FailureDetail(
              title: 'Terms and Conditions',
              description:
                  'You must agree to the terms and conditions of NRNA Austrailia for completing the registration.')));
      return;
    }

    final result = await signUpWithDetailsUseCase(UserRegisterParams(
      email: event.email,
      password: event.password,
      // fullName: event.fullName,
    ));

    result.fold((failure) {
      final detail = FailureDetail.fromAppFailure(failure);

      emit(SignUpState.registerFailed(detail: detail));
    }, (data) {
      emit(SignUpState.registerSuccess(registerResponseDetail: data));
    });
  }

  void _onSignUpEmailChanged(
      _SignUpEmailChanged event, Emitter<SignUpState> emit) {
    detail = detail.copyWith(
      email: event.email,
    );
  }

  void _onSignUpFullNameChanged(
      _SignUpFullNameChanged event, Emitter<SignUpState> emit) {
    detail = detail.copyWith(
      fullName: event.fullName,
    );
  }

  void _onSignUpPasswordChanged(
      _SignUpPasswordChanged event, Emitter<SignUpState> emit) {
    detail = detail.copyWith(
      password: event.password,
    );
  }

  void _onSignUpHasUserAgreedChanged(
      _SignUpHasUserAgreedChanged event, Emitter<SignUpState> emit) {
    detail = detail.copyWith(
      hasUserAgreed: event.hasUserAgreed,
    );
  }
}
