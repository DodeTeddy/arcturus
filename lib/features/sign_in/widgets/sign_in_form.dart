import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/responsive.dart';
import '../../../widgets/custom_elavated_button.dart';
import '../../../widgets/input_text_form_field.dart';
import '../providers/sign_in_provider.dart';
import 'input_password_form_field.dart';

class SignInForm extends StatelessWidget {
  final TextEditingController emailController;
  final String? Function(String?) emailValidator;
  final TextEditingController passwordController;
  final String? Function(String?) passwordValidator;
  final Function() signInOnTap;
  final Function() forgotPasswordOnTap;
  final Function() createAccountOnTap;
  const SignInForm({
    super.key,
    required this.emailController,
    required this.emailValidator,
    required this.passwordController,
    required this.passwordValidator,
    required this.signInOnTap,
    required this.forgotPasswordOnTap,
    required this.createAccountOnTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isLoading = context.watch<SignInProvider>().isLoading;

    return Column(
      children: [
        InputTextFormField(
          keyboardType: TextInputType.emailAddress,
          label: 'Email',
          controller: emailController,
          validator: emailValidator,
        ),
        SizedBox(
          height: Responsive.height(context, 2),
        ),
        InputPasswordFormField(
          label: 'Password',
          controller: passwordController,
          validator: passwordValidator,
        ),
        SizedBox(
          height: Responsive.height(context, 2),
        ),
        CustomElevatedButton(
          height: Responsive.height(context, 5),
          width: Responsive.getWidth(context),
          isLoading: isLoading,
          onPressed: signInOnTap,
          text: 'Sign In',
        ),
        SizedBox(
          height: Responsive.height(context, 2),
        ),
        GestureDetector(
          onTap: forgotPasswordOnTap,
          child: Text(
            'Forgot Password?',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        SizedBox(
          height: Responsive.height(context, 10),
        ),
        const Text('Don\'t have an account?'),
        SizedBox(
          height: Responsive.height(context, 1.5),
        ),
        GestureDetector(
          onTap: createAccountOnTap,
          child: Text(
            'Create Account',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        )
      ],
    );
  }
}
