import 'package:flutter/material.dart';

class DatePicker extends StatelessWidget {
  final DateTime initialDate;
  final DateTime firstDate;
  final Function(DateTime) onChanged;
  final String text;
  const DatePicker({
    super.key,
    required this.initialDate,
    required this.firstDate,
    required this.onChanged,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    Future<void> selectDate() async {
      DateTime? datePicked = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: DateTime(firstDate.year + 1, 1, 1 - 1),
      );

      if (datePicked != null) {
        onChanged(datePicked);
      }
    }

    return TextField(
      readOnly: true,
      onTap: selectDate,
      decoration: InputDecoration(
        hintText: text,
      ),
    );
  }
}
