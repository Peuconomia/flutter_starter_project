import 'package:app/core/palettes/palettes.dart';
import 'package:app/core/widgets/molecules/form_fields/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

import '../../../utils/responsive_builder_utils.dart';

class AppDatePickerWithHeader extends StatelessWidget {
  final Widget? header;
  final Widget? iconWidget;
  final String? label;

  final String name;
  final String? hintText;
  final Color? fillColor;
  final bool? filled;
  final bool enabled;

  final DateTime? initialDate;
  final DateTime? initialValue;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final ValueChanged<DateTime?>? onChanged;
  final String? Function(DateTime?)? validator;
  final DateFormat? format;
  final AutovalidateMode validationMode;
  final Key? datePickerKey;
  final InputType inputType;

  const AppDatePickerWithHeader({
    Key? key,
    this.datePickerKey,
    this.fillColor = AppPalette.kFormFieldFillColor,
    this.filled = true,
    this.header,
    this.iconWidget,
    this.label,
    this.inputType = InputType.both,
    this.initialDate,
    this.initialValue,
    this.firstDate,
    this.lastDate,
    this.onChanged,
    this.validator,
    this.format,
    this.enabled = true,
    this.validationMode = AutovalidateMode.disabled,
    required this.name,
    this.hintText,
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
        AppDatePicker(
          datePickerKey: datePickerKey,
          name: name,
          initialDate: initialDate,
          firstDate: firstDate,
          inputType: inputType,
          lastDate: lastDate,
          fillColor: fillColor,
          filled: filled,
          enabled: enabled,
          initialValue: initialValue,
          validator: validator,
          validationMode: validationMode,
          onChanged: onChanged,
          format: format,
          hintText: hintText,
        ),
      ],
    );
  }
}
