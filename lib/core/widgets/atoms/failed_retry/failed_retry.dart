import 'package:app/core/utils/responsive_builder_utils.dart';
import 'package:flutter/material.dart';

class FailedToLoadData extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? description;

  const FailedToLoadData({Key? key, this.onPressed, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double iconButtonIconSize = 48;
    const double actualIconSize = 32;

    final descriptionText = description ?? 'Failed to load data. Tap to retry.';

    return Center(
      child: Padding(
        padding: kScaffoldPadding(context: context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: onPressed,
                iconSize: iconButtonIconSize,
                icon: Container(
                  width: iconButtonIconSize,
                  height: iconButtonIconSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Icon(
                    Icons.sync,
                    size: actualIconSize,
                    color: Theme.of(context).colorScheme.background,
                  ),
                )),
            Flexible(child: Text(descriptionText)),
          ],
        ),
      ),
    );
  }
}
