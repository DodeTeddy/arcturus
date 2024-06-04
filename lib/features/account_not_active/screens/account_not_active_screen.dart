import 'dart:async';

import 'package:arcturus_mobile_app/utils/interceptors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/key.dart';
import '../../../constants/vector.dart';
import '../../../models/enum_condition.dart';
import '../../../routes/route.dart';
import '../../../utils/responsive.dart';
import '../../../utils/secure_storage.dart';
import '../../../utils/snack_bar.dart';
import '../../../widgets/custom_elavated_button.dart';
import '../../home/providers/profile_provider.dart';
import '../providers/launch_url_provider.dart';

class AccountNotActiveScreen extends StatelessWidget {
  const AccountNotActiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Uri url = Uri.parse('https://accounts.google.com');
    bool gotToEmailIsLoading = context.watch<LaunchUrlProvider>().isLoading;
    var launchEmailUrl = context.read<LaunchUrlProvider>().launchEmailUrl;
    bool activationStatusIsLoading = context.watch<ProfileProvider>().isLoading;

    void writeSecureData(String isActive) {
      SecureStorage().writeSecureData(accountActiveStatus, isActive);
    }

    void checkActivationStatus() {
      var response = context.read<ProfileProvider>().data;

      if (response.statusCode == 200) {
        var isActive = response.data!.data.isActive;

        if (isActive == '1') {
          snackBar(
            context: context,
            condition: Condition.success,
            message: 'Your account is active...',
          );
          writeSecureData(isActive);
          Timer(const Duration(milliseconds: 3000), () {
            Navigator.pushNamedAndRemoveUntil(context, mainScreen, (route) => false);
          });
        } else {
          snackBar(
            context: context,
            condition: Condition.failed,
            message: 'Your account is not active...',
          );
        }
      } else {
        snackBar(
          context: context,
          condition: Condition.failed,
          message: 'Something Error...',
        );
      }
    }

    void onPressedCheckActivation() async {
      var getProfile = context.read<ProfileProvider>().refetchGetProfile;

      await getProfile(context);

      checkActivationStatus();
    }

    void onPressedGoToEmail() {
      launchEmailUrl(url, context);
    }

    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: Responsive.height(context, 10),
                ),
                child: Column(
                  children: [
                    Text(
                      'Account Not Active',
                      style: TextStyle(
                        fontSize: Responsive.width(context, 5),
                      ),
                    ),
                    Image.asset(
                      checkEmail,
                      width: Responsive.width(context, 70),
                    ),
                    const Text('Please check your email to active your account'),
                    CustomElevatedButton(
                      isLoading: gotToEmailIsLoading,
                      onPressed: onPressedGoToEmail,
                      text: 'Go to email',
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: Responsive.height(context, 5),
                ),
                child: Column(
                  children: [
                    const Text('Already activated your account?'),
                    CustomElevatedButton(
                      isLoading: activationStatusIsLoading,
                      onPressed: onPressedCheckActivation,
                      text: 'Check activation status',
                    ),
                    TextButton.icon(
                      onPressed: () => interceptor(context, isLogout: true),
                      label: const Text('Log Out'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
