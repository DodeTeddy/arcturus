import 'package:flutter/material.dart';

class TimePicker extends StatelessWidget {
  final TimeOfDay initialTime;
  final Function(TimeOfDay) onChanged;
  final String text;
  const TimePicker({
    super.key,
    required this.initialTime,
    required this.onChanged,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    Future<void> selectTime() async {
      TimeOfDay? timePicked = await showTimePicker(
        context: context,
        initialTime: initialTime,
        initialEntryMode: TimePickerEntryMode.inputOnly,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        },
      );

      if (timePicked != null) {
        onChanged(timePicked);
      }
    }

    return TextField(
      readOnly: true,
      onTap: selectTime,
      decoration: InputDecoration(
        hintText: text,
      ),
    );
  }
}
