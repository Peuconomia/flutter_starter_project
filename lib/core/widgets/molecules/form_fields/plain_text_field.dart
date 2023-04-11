import 'package:app/core/palettes/palettes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AppTextFormField extends StatelessWidget {
  final String name;
  final String? initialValue;
  final String? hintText;
  final bool enabled;
  final int? maxLength;
  final String? Function(String?)? validator;
  final ValueChanged<String?>? onChanged;
  final AutovalidateMode validationMode;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? textInputType;
  final Color? fillColor;
  final bool? filled;
  final Key? formFieldKey;
  final FocusNode? focusNode;
  final int maxLines;

  const AppTextFormField({
    Key? key,
    this.formFieldKey,
    this.maxLines = 1,
    required this.name,
    this.hintText,
    this.maxLength,
    this.initialValue,
    this.inputFormatters,
    this.validator,
    this.textInputType,
    this.enabled = true,
    this.onChanged,
    this.controller,
    this.validationMode = AutovalidateMode.disabled,
    this.fillColor = AppPalette.kFormFieldFillColor,
    this.filled = true,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      focusNode: focusNode,
      key: formFieldKey,
      initialValue: initialValue,
      name: name,
      enabled: enabled,
      maxLines: maxLines,
      validator: validator,
      onChanged: onChanged,
      controller: controller,
      keyboardType: textInputType,
      inputFormatters: inputFormatters,
      autovalidateMode: validationMode,
      maxLength: maxLength,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.black,
            fontSize: 14,
          ),
      decoration: InputDecoration(
          fillColor: fillColor,
          filled: filled,
          alignLabelWithHint: true,
          hintText: hintText,
          errorMaxLines: 5),
    );
  }
}
