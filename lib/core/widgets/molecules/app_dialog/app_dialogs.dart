import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppDialog extends StatelessWidget {
  final Widget? content;
  final Widget? title;
  final List<Widget>? actions;

  const AppDialog({
    Key? key,
    this.content,
    this.title,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        actions: actions ?? [],
        title: title,
        content: content,
      );
    } else {
      return AlertDialog(
        title: title,
        content: content,
        actions: actions,
      );
    }
  }
}

class AppAlertDialog extends StatelessWidget {
  final String? content;
  final String? title;
  final BuildContext dialogContext;
  final VoidCallback? onPressed;
  final String actionText;

  const AppAlertDialog({
    Key? key,
    this.content,
    this.title,
    this.onPressed,
    this.actionText = 'OK',
    required this.dialogContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? dialogTitle;
    Widget? dialogContent;

    if (title != null) {
      dialogTitle = Text(title!, textAlign: TextAlign.center);
    }

    if (content != null) {
      dialogContent = Text(content!, textAlign: TextAlign.start);
    }

    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.of(dialogContext).pop();

              if (onPressed != null) {
                onPressed!();
              }
            },
            child: Text(
              actionText,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          )
        ],
        title: dialogTitle,
        content: dialogContent,
      );
    } else {
      return AlertDialog(
        title: dialogTitle,
        content: dialogContent,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();

                if (onPressed != null) {
                  onPressed!();
                }
              },
              child: Text(
                actionText.toUpperCase(),
              ))
        ],
      );
    }
  }

  static showAlertDialog({
    required BuildContext context,
    String? title,
    String? content,
    bool barrierDismissible = true,
    String actionText = 'Ok',
    VoidCallback? onActionPressed,
  }) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        barrierDismissible: barrierDismissible,
        context: context,
        builder: (dialogContext) => WillPopScope(
          onWillPop: () async => false,
          child: AppAlertDialog(
            dialogContext: dialogContext,
            title: title,
            content: content,
            actionText: actionText,
            onPressed: onActionPressed,
          ),
        ),
      );
    } else {
      showDialog(
        barrierDismissible: barrierDismissible,
        context: context,
        builder: (dialogContext) => WillPopScope(
          onWillPop: () async => false,
          child: AppAlertDialog(
            dialogContext: dialogContext,
            title: title,
            content: content,
            onPressed: onActionPressed,
            actionText: actionText,
          ),
        ),
      );
    }
  }
}

class AppConfirmDialog extends StatelessWidget {
  final String? content;
  final String? title;
  final String confirmText;
  final bool isConfirmDestructiveAction;
  final BuildContext dialogContext;
  final VoidCallback onConfirmPressed;

  const AppConfirmDialog({
    Key? key,
    this.content,
    this.title,
    this.isConfirmDestructiveAction = false,
    this.confirmText = 'Confirm',
    required this.onConfirmPressed,
    required this.dialogContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? dialogTitle;
    Widget? dialogContent;

    if (title != null) {
      dialogTitle = Text(title!, textAlign: TextAlign.center);
    }

    if (content != null) {
      dialogContent = Text(content!, textAlign: TextAlign.start);
    }

    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
            child: Text(
              'Cancel',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            isDestructiveAction: isConfirmDestructiveAction,
            onPressed: () {
              Navigator.of(dialogContext).pop();
              onConfirmPressed();
            },
            child: Text(
              confirmText,
              style: isConfirmDestructiveAction
                  ? null
                  : TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
        ],
        title: dialogTitle,
        content: dialogContent,
      );
    } else {
      return AlertDialog(
        title: dialogTitle,
        content: dialogContent,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text(
                'Cancel'.toUpperCase(),
              )),
          TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();

                onConfirmPressed();
              },
              child: Text(
                confirmText.toUpperCase(),
              )),
        ],
      );
    }
  }

  static showConfirmDialog({
    required BuildContext context,
    String? title,
    String? content,
    String confirmText = 'Ok',
    bool isConfirmDestructiveAction = false,
    required VoidCallback onConfirmPressed,
  }) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) => WillPopScope(
          onWillPop: () async => false,
          child: AppConfirmDialog(
            dialogContext: dialogContext,
            title: title,
            content: content,
            isConfirmDestructiveAction: isConfirmDestructiveAction,
            confirmText: confirmText,
            onConfirmPressed: onConfirmPressed,
          ),
        ),
      );
    } else {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) => WillPopScope(
          onWillPop: () async => false,
          child: AppConfirmDialog(
            dialogContext: dialogContext,
            title: title,
            content: content,
            isConfirmDestructiveAction: isConfirmDestructiveAction,
            confirmText: confirmText,
            onConfirmPressed: onConfirmPressed,
          ),
        ),
      );
    }
  }
}

class AppLoadingDialog extends StatelessWidget {
  final String? content;

  const AppLoadingDialog({
    Key? key,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? dialogContent;

    if (content != null) {
      dialogContent = Text(content!, textAlign: TextAlign.start);
    }

    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        actions: const [],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CupertinoActivityIndicator(),
            if (dialogContent != null) const SizedBox(height: 16),
            if (dialogContent != null) Flexible(child: dialogContent),
          ],
        ),
      );
    } else {
      return AlertDialog(
        content: Row(
          mainAxisAlignment: dialogContent != null
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            if (dialogContent != null) const SizedBox(width: 16),
            if (dialogContent != null) Flexible(child: dialogContent),
          ],
        ),
      );
    }
  }

  static showLoadingDialog({
    required BuildContext context,
    String? content,
  }) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) => WillPopScope(
          onWillPop: () async => false,
          child: AppLoadingDialog(
            content: content,
          ),
        ),
      );
    } else {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) => WillPopScope(
          onWillPop: () async => false,
          child: AppLoadingDialog(
            content: content,
          ),
        ),
      );
    }
  }
}
