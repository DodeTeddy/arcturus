import '../../../constants/color.dart';
import '../../../constants/vector.dart';
import '../providers/setting_provider.dart';
import '../../sign_in/utils/sign_in_validator.dart';
import '../../sign_in/widgets/input_password_form_field.dart';
import '../../../models/enum_condition.dart';
import '../../../utils/responsive.dart';
import '../../../utils/secure_storage.dart';
import '../../../utils/snack_bar.dart';
import '../../../widgets/custom_elavated_button.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../../constants/key.dart';
import '../../../routes/route.dart';
import '../../main/providers/nav_bar_provider.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final _updateKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  void checkSignOutProgress() {
    Navigator.pushNamedAndRemoveUntil(context, signInScreen, (route) => false);
    SecureStorage().deleteSecureData(bearerToken);
    SecureStorage().deleteSecureData(signInStatus);
    SecureStorage().deleteSecureData(accountActiveStatus);
    context.read<NavBarProvider>().onResetPageIndex();
  }

  void checkUpdateProgress() {
    var response = context.read<SettingProvider>().dataUpdate;

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Iconsax.verify,
                  size: Responsive.width(context, 25),
                  color: kGreenColor,
                ),
                Text(
                  'Success',
                  style: TextStyle(
                    fontSize: Responsive.width(context, 7),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Please login with your new password',
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
    } else {
      snackBar(
        context: context,
        condition: Condition.failed,
        message: 'Something Error...',
      );
    }
  }

  void onPressedReset() async {
    if (_updateKey.currentState!.validate()) {
      await context.read<SettingProvider>().updatePassword(_controller.text, context);

      checkUpdateProgress();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(height: Responsive.height(context, 15)),
                Image.asset(
                  resetPassword,
                  width: Responsive.width(context, 70),
                ),
                Form(
                  key: _updateKey,
                  child: Column(
                    children: [
                      InputPasswordFormField(
                        label: '',
                        controller: _controller,
                        validator: passwordValidator,
                      ),
                      SizedBox(height: Responsive.height(context, 2)),
                      CustomElevatedButton(
                        isLoading: context.watch<SettingProvider>().isLoadingUpdate,
                        onPressed: onPressedReset,
                        text: 'Update Password',
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
