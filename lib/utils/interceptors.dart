import 'dart:async';

import '../features/main/providers/nav_bar_provider.dart';

import '../constants/vector.dart';
import '../features/setting/providers/setting_provider.dart';
import 'responsive.dart';
import 'secure_storage.dart';
import '../widgets/custom_elavated_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/key.dart';
import '../routes/route.dart';

void checkSignOutProgress(BuildContext context) {
  Navigator.pushNamedAndRemoveUntil(context, signInScreen, (route) => false);
  SecureStorage().deleteSecureData(bearerToken);
  SecureStorage().deleteSecureData(signInStatus);
  SecureStorage().deleteSecureData(accountActiveStatus);
  context.read<NavBarProvider>().onResetPageIndex();
}

void interceptor(BuildContext context, {bool isLogout = false}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(errorVector, width: Responsive.width(context, 30)),
            Text(
              isLogout ? 'Are you sure?' : 'Your session has expired',
              style: TextStyle(
                fontSize: Responsive.width(context, 4),
              ),
            ),
          ],
        ),
        actions: [
          CustomElevatedButton(
            isLoading: context.watch<SettingProvider>().isLoading,
            onPressed: () async {
              await context.read<SettingProvider>().signOut();
              Timer(Duration.zero, () {
                checkSignOutProgress(context);
              });
            },
            text: 'Oke',
          )
        ],
      );
    },
  );
}
