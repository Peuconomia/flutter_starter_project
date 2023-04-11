import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppCheckBox extends StatefulWidget {
  final bool enabled;
  final String title;
  final ValueChanged<bool>? onChanged;
  final bool initialValue;
  final Color? color;

  const AppCheckBox({
    Key? key,
    required this.title,
    this.enabled = true,
    this.onChanged,
    this.initialValue = false,
    this.color,
  }) : super(key: key);

  @override
  State<AppCheckBox> createState() => AppCheckBoxState();
}

class AppCheckBoxState extends State<AppCheckBox> {
  bool value = false;

  @override
  void initState() {
    super.initState();

    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          if (!mounted) return;

          value = !value;
        });

        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              fillColor: widget.color != null
                  ? MaterialStateProperty.all(widget.color)
                  : null,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              value: value,
              onChanged: !widget.enabled
                  ? null
                  : (_) {
                      setState(() {
                        if (!mounted) return;

                        value = !value;
                      });

                      if (widget.onChanged != null) {
                        widget.onChanged!(value);
                      }
                    }),
          Flexible(
            child: Text(widget.title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: widget.color,
                )),
          ),
        ],
      ),
    );
  }

  void setRememberMeTo(bool rememberMe) {
    if (!mounted) return;

    setState(() {
      value = rememberMe;
    });
  }
}
