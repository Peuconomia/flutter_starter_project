import 'package:app/core/palettes/palettes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class AppDatePicker extends StatelessWidget {
  final Color? fillColor;
  final bool? filled;
  final bool enabled;
  final String name;
  final String? hintText;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? initialValue;
  final DateTime? lastDate;
  final AutovalidateMode validationMode;
  final ValueChanged<DateTime?>? onChanged;
  final String? Function(DateTime?)? validator;
  final DateFormat? format;
  final InputType inputType;
  final Key? datePickerKey;

  const AppDatePicker({
    Key? key,
    this.datePickerKey,
    required this.name,
    this.fillColor = AppPalette.kFormFieldFillColor,
    this.filled = true,
    this.enabled = true,
    this.initialDate,
    this.initialValue,
    this.inputType = InputType.both,
    this.firstDate,
    this.lastDate,
    this.onChanged,
    this.validator,
    this.format,
    this.validationMode = AutovalidateMode.disabled,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderDateTimePicker(
      key: datePickerKey,
      autovalidateMode: validationMode,
      decoration: InputDecoration(
        fillColor: fillColor,
        filled: filled,
        hintText: hintText,
        errorMaxLines: 5,
      ),
      style: Theme.of(context).textTheme.bodyMedium,
      name: name,
      enabled: enabled,
      resetIcon: null,
      initialValue: initialValue,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      inputType: inputType,
      validator: validator,
      format: format,
      onChanged: onChanged,
    );
  }
}
