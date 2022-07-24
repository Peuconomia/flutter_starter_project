import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

part 'home_mobile.dart';
part 'home_tablet.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (mobileContext) => const HomeMobileWidget(),
      tablet: (tabletContext) => const HomeTabletWidget(),
    );
  }
}
