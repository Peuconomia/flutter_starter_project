import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocObserver extends BlocObserver {
  final bool showDebugMessages;

  MyBlocObserver({this.showDebugMessages = true});

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    if (kDebugMode) {
      if (showDebugMessages) {
        print('OnCreate: ${bloc.runtimeType} state: ${bloc.state}');
      }
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      if (showDebugMessages) {
        print('onChange: ${bloc.runtimeType} change: $change');
      }
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (kDebugMode) {
      if (showDebugMessages) {
        print('OnTransition: ${bloc.runtimeType} transition: $transition');
      }
    }
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (kDebugMode) {
      if (showDebugMessages) {
        print('onEvent: ${bloc.runtimeType} event: $event');
      }
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    if (kDebugMode) {
      if (showDebugMessages) {
        print('OnError: ${bloc.runtimeType} error: $error\n$stackTrace');
      }
    }
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    if (kDebugMode) {
      if (showDebugMessages) {
        print('OnCLose: ${bloc.runtimeType} state: ${bloc.state}');
      }
    }
  }
}
