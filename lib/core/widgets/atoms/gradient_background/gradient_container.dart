import 'package:flutter/material.dart';

class GradientBackgroundContainer extends StatelessWidget {
  final Widget? child;

  const GradientBackgroundContainer({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xFFB3D1F1),
              Color(0xFFC6DAF1),
              Color(0xFFF8F3F0),
              Color(0xFFFFF8F8),
              Color(0xFFFFFBFB),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: <double>[
              0.0,
              0.15,
              0.4,
              0.8,
              1,
            ],
          ),
        ),
        child: child,
      ),
    );
  }
}
