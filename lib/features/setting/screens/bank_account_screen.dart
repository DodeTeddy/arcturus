import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../../constants/color.dart';
import '../../../constants/vector.dart';
import '../../../models/enum_condition.dart';
import '../../../utils/responsive.dart';
import '../../../utils/snack_bar.dart';
import '../../../widgets/custom_elavated_button.dart';
import '../../../widgets/input_text_form_field.dart';
import '../models/update_profile_request_body.dart';
import '../providers/setting_provider.dart';
import '../utils/validator.dart';

class BankAccountScreen extends StatefulWidget {
  const BankAccountScreen({super.key});

  @override
  State<BankAccountScreen> createState() => _BankAccountScreenState();
}

class _BankAccountScreenState extends State<BankAccountScreen> {
  final _generalInformationKey = GlobalKey<FormState>();
  final TextEditingController _swiftCodeController = TextEditingController();
  final TextEditingController _bankAccountController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _bankAddressController = TextEditingController();

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
                          city: dataProfile!.data.vendors.city!,
                          state: dataProfile.data.vendors.state!,
                          country: dataProfile.data.vendors.country!,
                          area: dataProfile.data.vendors.area!,
                          location: dataProfile.data.vendors.location!,
                          busisnessname: dataProfile.data.vendors.vendorName!,
                          legalname: dataProfile.data.vendors.legalName!,
                          address: dataProfile.data.vendors.addressLine1!,
                          address2: dataProfile.data.vendors.addressLine2!,
                          phone: dataProfile.data.vendors.phone!,
                          email: dataProfile.data.vendors.email!,
                          latitude: dataProfile.data.vendors.latitude!,
                          longitude: dataProfile.data.vendors.longitude!,
                          bank: _bankNameController.text,
                          bankaccount: _bankAccountController.text,
                          swifcode: _swiftCodeController.text,
                          bankaddress: _bankAddressController.text,
                          accountnumber: _accountNumberController.text,
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
      _swiftCodeController.text = data.dataProfile.data!.data.vendors.swifCode!;
      _bankAccountController.text = data.dataProfile.data!.data.vendors.bankAccount!;
      _bankNameController.text = data.dataProfile.data!.data.vendors.bankName!;
      _accountNumberController.text = data.dataProfile.data!.data.vendors.accountNumber!;
      _bankAddressController.text = data.dataProfile.data!.data.vendors.bankAddress!;
    }
  }

  void _getProfile() async {
    await context.read<SettingProvider>().getProfile(context);
    _controllerIntialValue();
  }

  @override
  void dispose() {
    _swiftCodeController.dispose();
    _bankAccountController.dispose();
    _bankNameController.dispose();
    _accountNumberController.dispose();
    _bankAddressController.dispose();
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
          'Bank Account',
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
                              label: 'Bank Account',
                              controller: _bankAccountController,
                              validator: (value) => validator(value),
                            ),
                            SizedBox(height: Responsive.height(context, 1)),
                            InputTextFormField(
                              label: 'Bank Name',
                              controller: _bankNameController,
                              validator: (value) => validator(value),
                            ),
                            SizedBox(height: Responsive.height(context, 1)),
                            InputTextFormField(
                              keyboardType: TextInputType.number,
                              label: 'Account Number',
                              controller: _accountNumberController,
                              validator: (value) => validator(value),
                            ),
                            SizedBox(height: Responsive.height(context, 1)),
                            InputTextFormField(
                              label: 'Bank Address',
                              controller: _bankAddressController,
                              validator: (value) => validator(value),
                            ),
                            SizedBox(height: Responsive.height(context, 1)),
                            InputTextFormField(
                              label: 'Swift Code',
                              controller: _swiftCodeController,
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
