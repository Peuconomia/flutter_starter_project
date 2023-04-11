import 'package:flutter/material.dart';

import '../../../utils/responsive_builder_utils.dart';

class AppElevatedButton extends StatelessWidget {
  final String title;
  final Widget? suffixWidget;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  const AppElevatedButton({
    Key? key,
    required this.title,
    this.suffixWidget,
    this.backgroundColor,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getValueForRefinedScreenType<Widget>(
      context: context,
      mobileSmall: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(double.infinity, 54),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.white),
              ),
            ),
            if (suffixWidget != null) suffixWidget!,
          ],
        ),
      ),
      mobileNormal: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(double.infinity, 54),
          backgroundColor: backgroundColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Colors.white),
              ),
            ),
            if (suffixWidget != null) suffixWidget!,
          ],
        ),
      ),
    );
  }
}
