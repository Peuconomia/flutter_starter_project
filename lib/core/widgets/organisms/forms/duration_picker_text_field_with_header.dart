import 'package:flutter/material.dart';

import '../../../utils/responsive_builder_utils.dart';
import '../../molecules/form_fields/duration_picker.dart';

class DurationPickerTextFieldWithHeader extends StatelessWidget {
  final String name;
  final TimeOfDay initialValue;
  final void Function(Duration)? durationChanged;
  final String? Function(String?)? validator;
  final String? helpText;
  final Widget? header;
  final Widget? iconWidget;
  final String? label;

  const DurationPickerTextFieldWithHeader({
    Key? key,
    required this.name,
    this.durationChanged,
    this.initialValue = const TimeOfDay(hour: 0, minute: 0),
    this.validator,
    this.helpText,
    this.header,
    this.iconWidget,
    this.label,
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
        DurationPickerTextField(
          name: name,
          durationChanged: durationChanged,
          initialValue: initialValue,
          helpText: helpText,
          validator: validator,
        )
      ],
    );
  }
}
