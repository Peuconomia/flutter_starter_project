import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SocialLoginWidget extends StatefulWidget {
  final String imagePath;
  final VoidCallback? onPressed;

  const SocialLoginWidget({Key? key, required this.imagePath, this.onPressed})
      : super(key: key);

  @override
  State<SocialLoginWidget> createState() => _SocialLoginWidgetState();
}

class _SocialLoginWidgetState extends State<SocialLoginWidget> {
  final double kIdleElevation = 4;
  final double kOnPressElevation = 8;

  double elevation = 0;

  @override
  void initState() {
    super.initState();

    elevation = kIdleElevation;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Material(
        elevation: elevation,
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        shadowColor: Colors.black,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: widget.onPressed,
          onTapDown: (_) {
            if (!mounted) return;

            setState(() {
              elevation = kOnPressElevation;
            });
          },
          onTapUp: (_) {
            if (!mounted) return;

            setState(() {
              elevation = kIdleElevation;
            });
          },
          onTapCancel: () {
            if (!mounted) return;

            setState(() {
              elevation = kIdleElevation;
            });
          }, // Handle your onTap
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: SvgPicture.asset(
              widget.imagePath,
            ),
          ),
        ),
      ),
    );
  }
}
