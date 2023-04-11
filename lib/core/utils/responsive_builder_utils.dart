// ignore_for_file: null_check_on_nullable_type_parameter

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

T getValueForRefinedScreenType<T>({
  required BuildContext context,
  required T mobileSmall,
  bool useHeight = false,
  T? mobileNormal,
  T? mobileLarge,
  T? mobileExtraLarge,
  T? tabletSmall,
  T? tabletNormal,
  T? tabletLarge,
  T? tabletExtraLarge,
  T? desktopSmall,
  T? desktopNormal,
  T? desktopLarge,
  T? desktopExtraLarge,
}) {
  final width = useHeight
      ? MediaQuery.of(context).size.height
      : MediaQuery.of(context).size.width;
  final refinedBreakpoints = ResponsiveSizingConfig.instance.refinedBreakpoints;

  // Assign parts
  mobileNormal ??= mobileSmall;
  mobileLarge ??= mobileNormal;
  mobileExtraLarge ??= mobileLarge;
  tabletSmall ??= mobileExtraLarge;
  tabletNormal ??= tabletSmall;
  tabletLarge ??= tabletNormal;
  tabletExtraLarge ??= tabletLarge;
  desktopSmall ??= tabletExtraLarge;
  desktopNormal ??= desktopSmall;
  desktopLarge ??= desktopNormal;
  desktopExtraLarge ??= desktopLarge;

  if (width <= refinedBreakpoints.mobileSmall) {
    return mobileSmall;
  } else if (width <= refinedBreakpoints.mobileNormal) {
    return mobileNormal!;
  } else if (width <= refinedBreakpoints.mobileLarge) {
    return mobileLarge!;
  } else if (width <= refinedBreakpoints.mobileExtraLarge) {
    return mobileExtraLarge!;
  } else if (width <= refinedBreakpoints.tabletSmall) {
    return tabletSmall!;
  } else if (width <= refinedBreakpoints.tabletNormal) {
    return tabletNormal!;
  } else if (width <= refinedBreakpoints.tabletLarge) {
    return tabletLarge!;
  } else if (width <= refinedBreakpoints.tabletExtraLarge) {
    return tabletExtraLarge!;
  } else if (width <= refinedBreakpoints.desktopSmall) {
    return desktopSmall!;
  } else if (width <= refinedBreakpoints.desktopNormal) {
    return desktopNormal!;
  } else if (width <= refinedBreakpoints.desktopLarge) {
    return desktopLarge!;
  } else {
    return desktopExtraLarge!;
  }
}

EdgeInsets kScaffoldPadding({required BuildContext context}) =>
    getValueForRefinedScreenType(
      context: context,
      mobileSmall: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      mobileNormal: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      mobileLarge: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      mobileExtraLarge:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      tabletSmall: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      tabletNormal: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      tabletLarge: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      tabletExtraLarge:
          const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      desktopSmall: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      desktopNormal: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      desktopLarge: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      desktopExtraLarge:
          const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
    );

void debugPrintScreenType(
    {required BuildContext context, bool useHeight = false}) {
  debugPrint('Current Screen Type: ${getValueForRefinedScreenType(
    context: context,
    useHeight: useHeight,
    mobileSmall: 'mobileSmall',
    mobileNormal: 'mobileNormal',
    mobileLarge: 'mobileLarge',
    mobileExtraLarge: 'mobileExtraLarge',
    tabletSmall: 'tabletSmall',
    tabletNormal: 'tabletNormal',
    tabletLarge: 'tabletLarge',
    tabletExtraLarge: 'tabletExtraLarge',
    desktopSmall: 'desktopSmall',
    desktopNormal: 'desktopNormal',
    desktopLarge: 'desktopLarge',
    desktopExtraLarge: 'desktopExtraLarge',
  )}');
}
