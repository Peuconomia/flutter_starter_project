import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../palettes/palettes.dart';

class AppPasswordFormField extends StatefulWidget {
  final String name;
  final String? hintText;
  final String? initialValue;
  final bool enabled;
  final String? Function(String?)? validator;
  final ValueChanged<String?>? onChanged;
  final int? maxLength;
  final AutovalidateMode validationMode;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? textInputType;
  final Color? fillColor;
  final bool? filled;

  const AppPasswordFormField({
    Key? key,
    required this.name,
    this.hintText,
    this.initialValue,
    this.inputFormatters,
    this.textInputType,
    this.validator,
    this.enabled = true,
    this.onChanged,
    this.maxLength,
    this.controller,
    this.fillColor = AppPalette.kFormFieldFillColor,
    this.filled = true,
    this.validationMode = AutovalidateMode.disabled,
  }) : super(key: key);

  @override
  State<AppPasswordFormField> createState() => _AppPasswordFormFieldState();
}

class _AppPasswordFormFieldState extends State<AppPasswordFormField> {
  bool hidePassword = true;

  @override
  void initState() {
    super.initState();
    hidePassword = true;
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      initialValue: widget.initialValue,
      name: widget.name,
      enabled: widget.enabled,
      maxLines: 1,
      controller: widget.controller,
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.textInputType,
      maxLength: widget.maxLength,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      validator: widget.validator,
      onChanged: widget.onChanged,
      obscureText: hidePassword,
      autovalidateMode: widget.validationMode,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.black,
            fontSize: 14,
          ),
      decoration: InputDecoration(
          fillColor: widget.enabled ? widget.fillColor : Colors.grey.shade300,
          filled: widget.filled,
          alignLabelWithHint: true,
          errorMaxLines: 5,
          hintText: widget.hintText,
          // hintStyle: const TextStyle(color: Color(0xFFA6A7A8), fontSize: 14),
          contentPadding: const EdgeInsets.all(16),
          suffixIcon: InkWell(
            child: Icon(hidePassword
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined),
            onTap: () {
              setState(() {
                if (!mounted) return;
                hidePassword = !hidePassword;
              });
            },
          )),
    );
  }
}
