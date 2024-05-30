import '../../../constants/color.dart';
import '../../../constants/vector.dart';
import '../models/update_profile_request_body.dart';
import '../providers/setting_provider.dart';
import '../utils/validator.dart';
import '../../sign_in/utils/sign_in_validator.dart';
import '../../../models/enum_condition.dart';
import '../../../utils/responsive.dart';
import '../../../utils/snack_bar.dart';
import '../../../widgets/custom_elavated_button.dart';
import '../../../widgets/input_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class GeneralInformationScreen extends StatefulWidget {
  const GeneralInformationScreen({super.key});

  @override
  State<GeneralInformationScreen> createState() => _GeneralInformationScreenState();
}

class _GeneralInformationScreenState extends State<GeneralInformationScreen> {
  final _generalInformationKey = GlobalKey<FormState>();
  final TextEditingController _agentNameController = TextEditingController();
  final TextEditingController _addressOneController = TextEditingController();
  final TextEditingController _addressTwoController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  void _checkSaveProgress() {
    var response = context.read<SettingProvider>().dataUpdatePost;

    if (response.statusCode == 200) {
      Navigator.pop(context);
      snackBar(
        context: context,
        condition: Condition.success,
        message: 'Update Profile Success...',
      );
      context.read<SettingProvider>().refetchGetProfile(context);
    } else {
      Navigator.pop(context);
      snackBar(
        context: context,
        condition: Condition.failed,
        message: 'Update Profile Failed...',
      );
    }
  }

  void _onSave() {
    if (_generalInformationKey.currentState!.validate()) {
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
                  color: kYellowColor,
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
                isLoading: context.watch<SettingProvider>().isLoadingUpdatePost,
                onPressed: () async {
                  var dataProfile = context.read<SettingProvider>().dataProfile.data;
                  await context.read<SettingProvider>().updateProfile(
                        UpdateProfileRequestBody(
                          city: _cityController.text,
                          state: _stateController.text,
                          country: dataProfile!.data.vendors.country!,
                          area: dataProfile.data.vendors.area!,
                          location: dataProfile.data.vendors.location!,
                          busisnessname: _agentNameController.text,
                          legalname: dataProfile.data.vendors.legalName!,
                          address: _addressOneController.text,
                          address2: _addressTwoController.text,
                          phone: _phoneController.text,
                          email: _emailController.text,
                          latitude: dataProfile.data.vendors.latitude!,
                          longitude: dataProfile.data.vendors.longitude!,
                          bank: dataProfile.data.vendors.bankName!,
                          bankaccount: dataProfile.data.vendors.bankAccount!,
                          swifcode: dataProfile.data.vendors.swifCode!,
                          bankaddress: dataProfile.data.vendors.bankAddress!,
                          accountnumber: dataProfile.data.vendors.accountNumber!,
                          distribute: "",
                        ),
                      );
                  _checkSaveProgress();
                },
                text: 'Oke',
              ),
            ],
          );
        },
      );
    }
  }

  void _controllerIntialValue() {
    var data = context.read<SettingProvider>();
    if (!data.isLoadingProfile && data.dataProfile.statusCode == 200) {
      _agentNameController.text = data.dataProfile.data!.data.vendors.vendorName!;
      _addressOneController.text = data.dataProfile.data!.data.vendors.addressLine1!;
      _addressTwoController.text = data.dataProfile.data!.data.vendors.addressLine2!;
      _phoneController.text = data.dataProfile.data!.data.vendors.phone!;
      _emailController.text = data.dataProfile.data!.data.vendors.email!;
      _stateController.text = data.dataProfile.data!.data.vendors.state!;
      _cityController.text = data.dataProfile.data!.data.vendors.city!;
    }
  }

  void _getProfile() async {
    await context.read<SettingProvider>().getProfile(context);
    _controllerIntialValue();
  }

  @override
  void dispose() {
    _agentNameController.dispose();
    _addressOneController.dispose();
    _addressTwoController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _stateController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var data = context.watch<SettingProvider>();

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Iconsax.arrow_left_2,
            color: kWhiteColor,
          ),
        ),
        title: Text(
          'General Information',
          style: TextStyle(
            fontSize: Responsive.width(context, 5),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: data.isLoadingProfile
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          : !data.isLoadingProfile && data.dataProfile.statusCode != 200
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        errorVector,
                        width: Responsive.width(context, 70),
                      ),
                      const Text('Something Error'),
                    ],
                  ),
                )
              : SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Form(
                        key: _generalInformationKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InputTextFormField(
                              label: 'Agent Name',
                              controller: _agentNameController,
                              validator: (value) => validator(value),
                            ),
                            SizedBox(height: Responsive.height(context, 1)),
                            InputTextFormField(
                              label: 'Address Line 1',
                              controller: _addressOneController,
                              validator: (value) => validator(value),
                            ),
                            SizedBox(height: Responsive.height(context, 1)),
                            InputTextFormField(
                              label: 'Address Line 2',
                              controller: _addressTwoController,
                              validator: (value) => validator(value),
                            ),
                            SizedBox(height: Responsive.height(context, 1)),
                            InputTextFormField(
                              keyboardType: TextInputType.phone,
                              label: 'Phone',
                              controller: _phoneController,
                              validator: (value) => validator(value),
                            ),
                            SizedBox(height: Responsive.height(context, 1)),
                            InputTextFormField(
                              label: 'Email',
                              controller: _emailController,
                              validator: (value) => emailValidator(value),
                            ),
                            SizedBox(height: Responsive.height(context, 1)),
                            InputTextFormField(
                              label: 'State',
                              controller: _stateController,
                              validator: (value) => validator(value),
                            ),
                            SizedBox(height: Responsive.height(context, 1)),
                            InputTextFormField(
                              label: 'City',
                              controller: _cityController,
                              validator: (value) => validator(value),
                            ),
                            SizedBox(height: Responsive.height(context, 1)),
                            CustomElevatedButton(
                              width: double.infinity,
                              onPressed: _onSave,
                              text: 'Save',
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
    );
  }
}
