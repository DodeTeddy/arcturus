import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../../constants/color.dart';
import '../../../constants/key.dart';
import '../../../routes/route.dart';
import '../../../utils/responsive.dart';
import '../../../utils/secure_storage.dart';
import '../../../widgets/custom_elavated_button.dart';
import '../../main/providers/nav_bar_provider.dart';
import '../providers/setting_provider.dart';
import '../widgets/button_section.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void checkSignOutProgress() {
      Navigator.pushNamedAndRemoveUntil(context, signInScreen, (route) => false);
      SecureStorage().deleteSecureData(bearerToken);
      SecureStorage().deleteSecureData(signInStatus);
      SecureStorage().deleteSecureData(accountActiveStatus);
      context.read<NavBarProvider>().onResetPageIndex();
    }

    void signOut() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Iconsax.danger,
                  size: Responsive.width(context, 25),
                  color: kRedColor,
                ),
                Text(
                  'Are you sure?',
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
                  checkSignOutProgress();
                },
                text: 'Oke',
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Settings',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: Responsive.width(context, 8),
                ),
              ),
              SizedBox(height: Responsive.height(context, 2)),
              ButtonSection(
                section: 'Profile',
                label: const ['General Information', 'Bank Account'],
                onLabelTap: (value) {
                  switch (value) {
                    case 0:
                      return Navigator.pushNamed(context, generalInformationScreen);
                    case 1:
                      return Navigator.pushNamed(context, bankAccountScreen);
                    default:
                  }
                },
              ),
              ButtonSection(
                section: 'Security',
                label: const ['Password'],
                onLabelTap: (value) {
                  if (value == 0) Navigator.pushNamed(context, updatePasswordScreen);
                },
              ),
              CustomElevatedButton(
                width: double.infinity,
                onPressed: signOut,
                text: 'Sign Out',
              )
            ],
          ),
        ),
      ),
    );
  }
}
