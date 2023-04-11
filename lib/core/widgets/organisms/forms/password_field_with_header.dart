import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../palettes/palettes.dart';
import '../../molecules/form_fields/password_field.dart';

class AppPasswordFormFieldWithHeader extends StatelessWidget {
  final String name;
  final String? hintText;
  final String? initialValue;
  final bool enabled;
  final String? Function(String?)? validator;
  final ValueChanged<String?>? onChanged;
  final int? maxLength;
  final AutovalidateMode validationMode;
  final Widget? header;
  final Widget? iconWidget;
  final String? label;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final Color? fillColor;
  final bool? filled;

  const AppPasswordFormFieldWithHeader({
    Key? key,
    required this.name,
    this.hintText,
    this.validator,
    this.inputFormatters,
    this.enabled = true,
    this.onChanged,
    this.maxLength,
    this.validationMode = AutovalidateMode.disabled,
    this.header,
    this.controller,
    this.iconWidget,
    this.label,
    this.initialValue,
    this.textInputType,
    this.fillColor = AppPalette.kFormFieldFillColor,
    this.filled = true,
  })  : assert(
            (header != null && (iconWidget == null && label == null)) ||
                (header == null && (iconWidget != null || label != null)),
            "Either child must be provided or (an icon or a label) must be provided but never both or none."),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget childHeader = const SizedBox();

    if (header != null) {
      childHeader = header ?? childHeader;
    } else {
      childHeader = Row(
        children: [
          if (iconWidget != null) iconWidget!,
          if (iconWidget != null && label != null) const SizedBox(width: 8),
          if (label != null)
            Flexible(
                child: Text(
              label ?? '',
              style: Theme.of(context).textTheme.titleSmall,
            )),
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        childHeader,
        if (iconWidget != null || label != null || header != null)
          const SizedBox(height: 8),
        AppPasswordFormField(
          name: name,
          filled: filled,
          inputFormatters: inputFormatters,
          initialValue: initialValue,
          textInputType: textInputType,
          fillColor: fillColor,
          controller: controller,
          hintText: hintText,
          validator: validator,
          onChanged: onChanged,
          enabled: enabled,
          maxLength: maxLength,
          validationMode: validationMode,
        ),
      ],
    );
  }
}
