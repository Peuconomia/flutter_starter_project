import 'dart:async';
import 'dart:isolate';

import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/apps/app.dart';
import 'core/apps/device_preview_app.dart';
import 'core/bloc_observers/bloc_observer.dart';
import 'core/config_reader/config_reader.dart';
import 'core/injections/injections.dart';
import 'core/routes/app_router.dart';

final appRouter = AppRouter();

void main() async {
  Bloc.observer = MyBlocObserver();

  runZonedGuarded<Future<void>>(
    () async {
      await initAndRunApp();
    },
    (error, stack) =>
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true),
  );
}

Future _initialiseApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // GetIt configuration
  configureDependencies();
  await getIt<ConfigReader>().initialize();
}

Future initAndRunApp() async {
  await _initialiseApp();

  Isolate.current.addErrorListener(RawReceivePort((pair) async {
    final List<dynamic> errorAndStacktrace = pair;
    await FirebaseCrashlytics.instance.recordError(
      errorAndStacktrace.first,
      errorAndStacktrace.last,
      fatal: true,
    );
  }).sendPort);

  if (!kReleaseMode && getIt<ConfigReader>().isDevicePreviewEnabled) {
    runApp(
      DevicePreview(
        enabled: !kReleaseMode,

        builder: (context) => const DevicePreviewApp(), // Wrap your app
      ),
    );
  } else {
    runApp(const MyApp());
  }
}
