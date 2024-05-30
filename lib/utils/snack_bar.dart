import 'package:flutter/material.dart';

import '../constants/color.dart';
import '../models/enum_condition.dart';

void snackBar({required BuildContext context, required Condition condition, required String message}) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: Condition.success == condition ? kGreenColor : kRedColor,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(milliseconds: 2000),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
