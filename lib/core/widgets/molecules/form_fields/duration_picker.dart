import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../helpers/input_borders.dart';

class DurationPickerTextField extends StatefulWidget {
  final String name;
  final TimeOfDay initialValue;
  final void Function(Duration)? durationChanged;
  final String? Function(String?)? validator;
  final String? helpText;

  const DurationPickerTextField({
    Key? key,
    required this.name,
    this.durationChanged,
    this.initialValue = const TimeOfDay(hour: 0, minute: 0),
    this.validator,
    this.helpText,
  }) : super(key: key);

  @override
  State<DurationPickerTextField> createState() =>
      _DurationPickerTextFieldState();
}

class _DurationPickerTextFieldState extends State<DurationPickerTextField> {
  TimeOfDay timeOfDay = const TimeOfDay(hour: 0, minute: 0);

  @override
  void initState() {
    super.initState();

    timeOfDay = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    String? timeStr;

    timeStr = '${timeOfDay.hour} hr(s) ${timeOfDay.minute} min(s)';

    return GestureDetector(
      onTap: () async {
        TimeOfDay? newTimeOfDay = await showTimePicker(
          context: context,
          helpText: widget.helpText,
          initialTime: timeOfDay,
          initialEntryMode: TimePickerEntryMode.inputOnly,
          builder: (BuildContext context, Widget? child) {
            return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child!,
            );
          },
        );

        if (newTimeOfDay != null) {
          if (newTimeOfDay == timeOfDay) {
            return;
          } else {
            widget.durationChanged?.call(Duration(
              hours: newTimeOfDay.hour,
              minutes: newTimeOfDay.minute,
            ));

            if (context.mounted) {
              setState(() {
                timeOfDay = newTimeOfDay;

                debugPrint(timeOfDay.toString());
              });
            }
          }
        }
      },
      child: Theme(
        data: Theme.of(context).copyWith(
            inputDecorationTheme:
                Theme.of(context).inputDecorationTheme.copyWith(
                      fillColor: Colors.white,
                      filled: true,
                      errorBorder: kErrorInputBorder,
                      focusedErrorBorder: kFocusedErrorInputBorder,
                      focusedBorder: kFocusedInputBorder,
                      disabledBorder: kEnabledInputBorder,
                      enabledBorder: kEnabledInputBorder,
                      border: kDefaultInputBorder,
                      errorMaxLines: 5,
                    )),
        child: FormBuilderTextField(
          key: UniqueKey(),
          style: Theme.of(context).textTheme.bodyMedium,
          name: '${widget.name}_${DateTime.now().millisecondsSinceEpoch}',
          enabled: false,
          initialValue: timeStr,
          validator: widget.validator,
        ),
      ),
    );
  }
}
