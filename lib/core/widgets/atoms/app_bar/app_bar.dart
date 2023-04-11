import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

AppBar customAppBar(
  BuildContext context, {
  required String title,
  bool centerTitle = true,
  Color? backgroundColor,
  Color? foregroundColor,
}) {
  return AppBar(
    centerTitle: centerTitle,
    leading: TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      onPressed: () {
        context.router.pop();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.arrow_back_ios_new_rounded,
              size: 16,
              color: foregroundColor ??
                  Theme.of(context).appBarTheme.foregroundColor),
          // Text('Back'),
        ],
      ),
    ),
    title: Text(
      title,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color:
              foregroundColor ?? Theme.of(context).appBarTheme.foregroundColor),
    ),
    backgroundColor: backgroundColor,
  );
}

AppBar customFlexibleAppBar(
  BuildContext context, {
  String? title,
  List<Widget>? trailing,
  VoidCallback? onBackPressed,
  bool centerTitle = true,
  Color? backgroundColor,
  Color? foregroundColor,
}) {
  return AppBar(
    centerTitle: centerTitle,
    leading: TextButton(
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      onPressed: onBackPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 16,
            color: foregroundColor ??
                Theme.of(context).appBarTheme.foregroundColor,
          ),
          // Text('Back'),
        ],
      ),
    ),
    title: title != null
        ? Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: foregroundColor ??
                      Theme.of(context).appBarTheme.foregroundColor,
                ),
          )
        : null,
    actions: trailing,
    backgroundColor: backgroundColor,
  );
}
