import 'package:app/core/entities/no_params.dart';
import 'package:app/features/auth/domain/entities/login_detail/login_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/failures/app_failures.dart';
import '../../../domain/entities/login__response_detail/login_response_detail.dart';
import '../../../domain/usecases/get_saved_login_detail.dart';
import '../../../domain/usecases/remove_saved_login_detail.dart';
import '../../../domain/usecases/save_login_detail.dart';
import '../../../domain/usecases/sign_in_with_credentials.dart';

part 'sign_in_bloc.freezed.dart';
part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInWithCredentialsUseCase signInWithCredentialsUseCase;

  final SaveLoginDetailUseCase saveLoginDetailUseCase;
  final GetSavedLoginDetailUseCase getSavedLoginDetailUseCase;
  final RemoveSavedLoginDetailUseCase removeSavedLoginDetailUseCase;

  LoginDetail _detail = const LoginDetail();

  LoginDetail get detail => _detail.copyWith();

  SignInBloc({
    required this.signInWithCredentialsUseCase,
    required this.saveLoginDetailUseCase,
    required this.getSavedLoginDetailUseCase,
    required this.removeSavedLoginDetailUseCase,
  }) : super(SignInState.initial()) {
    on<_InitializeTriggered>(_onInitializeTriggered);
    on<_SignInUsernameChanged>(_onSignInUsernameChanged);
    on<_SignInPasswordChanged>(_onSignInPasswordChanged);
    on<_SignInRememberMeChanged>(_onSignInRememberMeChanged);
    on<_SignInWithCredentialsPressed>(_onSignInWithCredentialsPressed);
  }

  void _onInitializeTriggered(
      _InitializeTriggered event, Emitter<SignInState> emit) async {
    emit(SignInState.initializing());

    final result = await getSavedLoginDetailUseCase(NoParams());

    result.fold((failure) {
      emit(SignInState.initializationFailed());
    }, (detail) {
      emit(SignInState.initialized(detail: detail));
    });
  }

  void _onSignInUsernameChanged(
      _SignInUsernameChanged event, Emitter<SignInState> emit) {
    _detail = _detail.copyWith(
      username: event.username,
    );
  }

  void _onSignInPasswordChanged(
      _SignInPasswordChanged event, Emitter<SignInState> emit) {
    _detail = _detail.copyWith(
      password: event.password,
    );
  }

  void _onSignInRememberMeChanged(
      _SignInRememberMeChanged event, Emitter<SignInState> emit) {
    _detail = _detail.copyWith(
      rememberMe: event.rememberMe,
    );
  }

  void _onSignInWithCredentialsPressed(
      _SignInWithCredentialsPressed event, Emitter<SignInState> emit) async {
    emit(SignInState.loginStarting());

    final result = await signInWithCredentialsUseCase(LoginParams(
      username: _detail.username,
      password: _detail.password,
      rememberCredentials: _detail.rememberMe,
    ));

    result.fold((failure) {
      emit(SignInState.loginFailure(failure: failure));
    }, (detail) {
      if (_detail.rememberMe) {
        saveLoginDetailUseCase(SaveLoginDetailParams(detail: _detail));
      } else {
        removeSavedLoginDetailUseCase(NoParams());
      }

      emit(SignInState.loginSuccess(detail: detail));
    });
  }
}
