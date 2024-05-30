import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/responsive.dart';
import '../../../widgets/custom_elavated_button.dart';
import '../../../widgets/input_text_form_field.dart';
import '../../sign_in/widgets/input_password_form_field.dart';
import '../models/dropdown_country_model.dart';
import '../providers/sign_up_provider.dart';
import 'dropdown_country.dart';

class SignUpForm extends StatelessWidget {
  final TextEditingController firstNameController;
  final String? Function(String?) firstNameValidator;
  final TextEditingController lastNameController;
  final String? Function(String?) lastNameValidator;
  final TextEditingController agentNameController;
  final String? Function(String?) agentNameValidator;
  final TextEditingController addressController;
  final String? Function(String?) addressValidator;
  final TextEditingController emailController;
  final String? Function(String?) emailValidator;
  final TextEditingController phoneController;
  final String? Function(String?) phoneValidator;
  final Function(DropdownCountryModel?) onChangedCountry;
  final String? Function(DropdownCountryModel?)? countryValidator;
  final TextEditingController stateController;
  final String? Function(String?) stateValidator;
  final TextEditingController cityController;
  final String? Function(String?) cityValidator;
  final TextEditingController passwordController;
  final String? Function(String?) passwordValidator;
  final Function() signUpOnTap;
  const SignUpForm({
    super.key,
    required this.firstNameController,
    required this.firstNameValidator,
    required this.lastNameController,
    required this.lastNameValidator,
    required this.agentNameController,
    required this.agentNameValidator,
    required this.addressController,
    required this.addressValidator,
    required this.emailController,
    required this.emailValidator,
    required this.phoneController,
    required this.phoneValidator,
    required this.onChangedCountry,
    required this.countryValidator,
    required this.stateController,
    required this.stateValidator,
    required this.cityController,
    required this.cityValidator,
    required this.passwordController,
    required this.passwordValidator,
    required this.signUpOnTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isLoading = context.watch<SignUpProvider>().isLoading;

    return Column(
      children: [
        InputTextFormField(
          label: 'First Name',
          controller: firstNameController,
          validator: firstNameValidator,
        ),
        SizedBox(
          height: Responsive.height(context, 1),
        ),
        InputTextFormField(
          label: 'Last Name',
          controller: lastNameController,
          validator: lastNameValidator,
        ),
        SizedBox(
          height: Responsive.height(context, 1),
        ),
        InputTextFormField(label: 'Agent Name', controller: agentNameController, validator: agentNameValidator),
        SizedBox(
          height: Responsive.height(context, 1),
        ),
        InputTextFormField(
          label: 'Address',
          controller: addressController,
          validator: addressValidator,
        ),
        SizedBox(
          height: Responsive.height(context, 1),
        ),
        InputTextFormField(
          keyboardType: TextInputType.emailAddress,
          label: 'Email',
          controller: emailController,
          validator: emailValidator,
        ),
        SizedBox(
          height: Responsive.height(context, 1),
        ),
        InputTextFormField(
          keyboardType: TextInputType.phone,
          label: 'Phone',
          controller: phoneController,
          validator: phoneValidator,
        ),
        SizedBox(
          height: Responsive.height(context, 1),
        ),
        DropdownCountry(
          onChanged: onChangedCountry,
          validator: countryValidator,
        ),
        SizedBox(
          height: Responsive.height(context, 1),
        ),
        Row(
          children: [
            Expanded(
              child: InputTextFormField(
                label: 'State',
                controller: stateController,
                validator: stateValidator,
              ),
            ),
            SizedBox(
              width: Responsive.width(context, 2),
            ),
            Expanded(
              child: InputTextFormField(
                label: 'City',
                controller: cityController,
                validator: cityValidator,
              ),
            ),
          ],
        ),
        SizedBox(
          height: Responsive.height(context, 1),
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
          onPressed: signUpOnTap,
          text: 'Sign Up',
        )
      ],
    );
  }
}
