import 'dart:async';

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
import '../../../widgets/custom_layout.dart';
import '../../../widgets/input_text_form_field.dart';
import '../models/sign_in_request_body.dart';
import '../providers/sign_in_provider.dart';
import '../utils/sign_in_validator.dart';
import '../widgets/sign_in_form.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignInScreen> {
  final _signInFormKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _emailForgetController;

  void writeSecureData(String token, String isActive) {
    SecureStorage().writeSecureData(signInStatus, 'true');
    SecureStorage().writeSecureData(bearerToken, token);
    SecureStorage().writeSecureData(accountActiveStatus, isActive);
  }

  void checkSignInProses() {
    var response = context.read<SignInProvider>().data;

    if (response.statusCode == 200) {
      snackBar(
        context: context,
        condition: Condition.success,
        message: 'Sign in successfully',
      );
      writeSecureData(
        response.data!.token,
        response.data!.user.isActive,
      );
      Timer(const Duration(milliseconds: 3000), () {
        if (response.data!.user.isActive == '0') {
          Navigator.pushNamedAndRemoveUntil(context, accountNotActiveScreen, (route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(context, mainScreen, (route) => false);
        }
      });
    } else {
      snackBar(
        context: context,
        condition: Condition.failed,
        message: response.statusCode == 401 ? 'Email or Password Wrong...' : 'Something wrong...',
      );
    }
  }

  void signInOnTap() async {
    if (_signInFormKey.currentState!.validate()) {
      var signIn = context.read<SignInProvider>().signIn;

      await signIn(SignInRequestBody(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      ));

      checkSignInProses();
    }
  }

  void onPressedReset() {
    var response = context.read<SignInProvider>();

    if (response.dataReset.statusCode == 200) {
      Navigator.pop(context);
      snackBar(
        context: context,
        condition: Condition.success,
        message: 'Check your email',
      );
    } else {
      snackBar(
        context: context,
        condition: Condition.failed,
        message: 'Email not registered',
      );
    }
  }

  void forgotPassword() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Reset Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InputTextFormField(label: 'Email', controller: _emailForgetController),
            ],
          ),
          actions: [
            CustomElevatedButton(
              isLoading: context.watch<SignInProvider>().isLoadingReset,
              onPressed: () async {
                if (_emailForgetController.text.isNotEmpty) {
                  await context.read<SignInProvider>().resetPasword(_emailForgetController.text);

                  onPressedReset();
                }
              },
              text: 'Reset',
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailForgetController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailForgetController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: CustomLayout(
            child: Column(
              children: [
                Image.asset(
                  signInVector,
                  width: Responsive.width(context, 65),
                ),
                SizedBox(
                  height: Responsive.height(context, 2),
                ),
                Form(
                  key: _signInFormKey,
                  child: SignInForm(
                    emailController: _emailController,
                    emailValidator: emailValidator,
                    passwordController: _passwordController,
                    passwordValidator: passwordValidator,
                    signInOnTap: signInOnTap,
                    forgotPasswordOnTap: forgotPassword,
                    createAccountOnTap: () => Navigator.pushNamed(context, signUpScreen),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
