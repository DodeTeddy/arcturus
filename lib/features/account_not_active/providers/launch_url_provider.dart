import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/enum_condition.dart';
import '../../../utils/snack_bar.dart';

class LaunchUrlProvider with ChangeNotifier {
  bool isLoading = false;

  launchEmailUrl(Uri url, BuildContext context) async {
    isLoading = true;
    notifyListeners();

    if (!await launchUrl(url)) {
      Timer(Duration.zero, () {
        snackBar(
          context: context,
          condition: Condition.failed,
          message: 'Could not launch $url',
        );
      });
    }
    isLoading = false;
    notifyListeners();
  }
}
