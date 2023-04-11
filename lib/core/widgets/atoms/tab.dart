import 'package:app/core/palettes/palettes.dart';
import 'package:app/core/themes/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/responsive_builder_utils.dart';

class AppDefaultTab extends StatelessWidget {
  final ValueListenable<int> currentSelectedTab;

  final int index;
  final String? svgAsset;
  final String title;

  const AppDefaultTab({
    required this.index,
    this.svgAsset,
    required this.title,
    required this.currentSelectedTab,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentSelectedTab,
      builder: (BuildContext buildContext, int value, Widget? child) {
        return Container(
          padding: kScaffoldPadding(context: buildContext),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: value == index
                    ? Theme.of(context).primaryColor
                    : const Color(0xFFE9EEF6),
                width: 2,
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (svgAsset != null)
                SvgPicture.asset(
                  svgAsset!,
                  width: 16,
                  color: currentSelectedTab.value == index
                      ? Theme.of(buildContext).primaryColor
                      : AppPalette.kTextColorLight,
                ),
              if (svgAsset != null) const SizedBox(width: 10),
              Text(title,
                  style: Theme.of(buildContext).textTheme.titleMedium?.copyWith(
                        fontFamily: ThemeManager.kFontFamily,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: currentSelectedTab.value == index
                            ? Theme.of(buildContext).primaryColor
                            : AppPalette.kTextColorLight,
                      )),
            ],
          ),
        );
      },
    );
  }
}
