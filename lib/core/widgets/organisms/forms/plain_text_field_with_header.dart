import 'package:app/core/utils/responsive_builder_utils.dart';
import 'package:app/core/widgets/molecules/form_fields/plain_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../palettes/palettes.dart';

class AppTextFormFieldWithHeader extends StatelessWidget {
  final String name;
  final String? hintText;
  final String? initialValue;
  final bool enabled;
  final String? Function(String?)? validator;
  final ValueChanged<String?>? onChanged;
  final AutovalidateMode validationMode;
  final Widget? header;
  final Widget? iconWidget;
  final String? label;
  final TextEditingController? controller;
  final Color? fillColor;
  final bool? filled;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final Key? formFieldKey;
  final int maxLines;

  const AppTextFormFieldWithHeader({
    Key? key,
    required this.name,
    this.formFieldKey,
    this.hintText,
    this.maxLength,
    this.initialValue,
    this.inputFormatters,
    this.validator,
    this.textInputType,
    this.enabled = true,
    this.onChanged,
    this.validationMode = AutovalidateMode.disabled,
    this.header,
    this.iconWidget,
    this.controller,
    this.label,
    this.fillColor = AppPalette.kFormFieldFillColor,
    this.filled = true,
    this.maxLines = 1,
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        childHeader,
        if (iconWidget != null || label != null || header != null)
          SizedBox(
              height: getValueForRefinedScreenType(
                  context: context, mobileSmall: 8, tabletSmall: 16)),
        AppTextFormField(
          formFieldKey: formFieldKey,
          fillColor: fillColor,
          filled: filled,
          initialValue: initialValue,
          name: name,
          maxLines: maxLines,
          textInputType: textInputType,
          inputFormatters: inputFormatters,
          controller: controller,
          hintText: hintText,
          maxLength: maxLength,
          validator: validator,
          enabled: enabled,
          onChanged: onChanged,
          validationMode: validationMode,
        ),
      ],
    );
  }
}
