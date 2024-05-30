import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/vector.dart';
import '../../../models/enum_condition.dart';
import '../../../utils/responsive.dart';
import '../../../utils/snack_bar.dart';
import '../../../widgets/custom_layout.dart';
import '../../sign_in/utils/sign_in_validator.dart';
import '../models/sign_up_request_body.dart';
import '../providers/sign_up_provider.dart';
import '../utils/sign_up_validator.dart';
import '../widgets/sign_up_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _signUpFormKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _agentNameController;
  late TextEditingController _addressController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _stateController;
  late TextEditingController _cityController;
  late TextEditingController _passwordController;
  late String countrySelected;

  void checkSignUpProses() {
    var response = context.read<SignUpProvider>().data;

    if (response.statusCode == 200) {
      snackBar(
        context: context,
        condition: Condition.success,
        message: response.data,
      );
      Timer(const Duration(milliseconds: 3000), () {
        Navigator.pop(context);
      });
    } else {
      snackBar(
        context: context,
        condition: Condition.failed,
        message: response.data,
      );
    }
  }

  void signUpOnTap() async {
    if (_signUpFormKey.currentState!.validate()) {
      var register = context.read<SignUpProvider>().signUp;

      await register(
        SignUpRequestBody(
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          phone: _phoneController.text.trim(),
          busisnesName: _agentNameController.text.trim(),
          companyName: _agentNameController.text.trim(),
          address: _addressController.text.trim(),
          city: _cityController.text.trim(),
          state: _stateController.text.trim(),
          country: countrySelected,
        ),
      );

      checkSignUpProses();
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _agentNameController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _stateController.dispose();
    _cityController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _agentNameController = TextEditingController();
    _addressController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _stateController = TextEditingController();
    _cityController = TextEditingController();
    _passwordController = TextEditingController();
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
                  signUpVector,
                  width: Responsive.width(context, 65),
                ),
                SizedBox(
                  height: Responsive.height(context, 2),
                ),
                Form(
                  key: _signUpFormKey,
                  child: SignUpForm(
                    firstNameController: _firstNameController,
                    firstNameValidator: (value) => signUpValidator(value, 'First Name'),
                    lastNameController: _lastNameController,
                    lastNameValidator: (value) => signUpValidator(value, 'Last Name'),
                    agentNameController: _agentNameController,
                    agentNameValidator: (value) => signUpValidator(value, 'Agent Name'),
                    addressController: _addressController,
                    addressValidator: (value) => signUpValidator(value, 'Address'),
                    emailController: _emailController,
                    emailValidator: emailValidator,
                    phoneController: _phoneController,
                    phoneValidator: (value) => signUpValidator(value, 'Phone'),
                    onChangedCountry: (value) => value != null ? countrySelected = value.label : '',
                    countryValidator: (value) => signUpValidator(value == null ? '' : value.label, 'Country'),
                    stateController: _stateController,
                    stateValidator: (value) => signUpValidator(value, 'State'),
                    cityController: _cityController,
                    cityValidator: (value) => signUpValidator(value, 'City'),
                    passwordController: _passwordController,
                    passwordValidator: passwordValidator,
                    signUpOnTap: signUpOnTap,
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
