import 'package:app/core/constants/app_failure_messages.dart';
import 'package:app/core/failures/app_failures.dart';
import 'package:app/core/widgets/molecules/app_dialog/app_dialogs.dart';
import 'package:app/features/auth/data/datasources/auth_local.dart';
import 'package:flutter/widgets.dart';

import '../injections/injections.dart';

abstract class UserUnauthorizedHandler {
  static bool _isShowing = false;

  static bool get isShowing => _isShowing;

  static void handleUnauthorized(
      {required BuildContext context,
      required AppFailure failure,
      VoidCallback? onAuthorized}) async {
    if (_isShowing) return;

    // handle only when unauthorized
    failure.maybeMap(unAuthorized: (_) {
      // set _isShowing to true
      _isShowing = true;

      // Sign out the user
      getIt<AuthLocalDataSource>().signOut();

      // Show Alert dialog
      AppAlertDialog.showAlertDialog(
        context: context,
        content: AppFailureMessages.kUnauthorized,
        actionText: 'Login',
        title: 'Session Expired!',
        barrierDismissible: false,
        onActionPressed: () {
          _isShowing = false;

          /// TODO : add login route
          // appRouter.replaceAll([const LoginRoute()]);
        },
      );
    }, orElse: () {
      if (onAuthorized != null) {
        onAuthorized();
      }
    });
  }
}
