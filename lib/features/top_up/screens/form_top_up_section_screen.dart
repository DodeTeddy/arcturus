import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:arcturus_mobile_app/features/top_up/models/top_up_request_model.dart';
import 'package:arcturus_mobile_app/features/top_up/providers/top_up_provider.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../constants/color.dart';
import '../../../models/enum_condition.dart';
import '../../../utils/responsive.dart';
import '../../../utils/snack_bar.dart';
import '../../../widgets/custom_elavated_button.dart';
import '../../../widgets/input_text_form_field.dart';

class FormTopUpSectionScreen extends StatefulWidget {
  const FormTopUpSectionScreen({super.key});

  @override
  State<FormTopUpSectionScreen> createState() => _FormTopUpSectionScreenState();
}

class _FormTopUpSectionScreenState extends State<FormTopUpSectionScreen> {
  Random random = Random();
  final TextEditingController _controller = TextEditingController();
  bool isTopUpValid = false;
  bool isGenerate = false;
  double? totalTopUp;
  File? file;

  void _copy({bool isTotal = false}) async {
    await FlutterClipboard.copy(isTotal ? _controller.text : '2027999995');
    Timer(Duration.zero, () {
      snackBar(context: context, condition: Condition.success, message: '📝 text Copied to clipboard');
    });
  }

  void _generateUniqueCode() {
    if (_controller.text.isNotEmpty && _controller.text.length > 4) {
      setState(() {
        isTopUpValid = true;
      });
      String uniqueCode = '${random.nextInt(9) + 1}${random.nextInt(9) + 1}${random.nextInt(9) + 1}';
      setState(() {
        totalTopUp = double.parse(_controller.text) + double.parse(uniqueCode);
        isGenerate = true;
        _controller.text = totalTopUp!.ceil().toString();
      });
    } else {
      setState(() {
        isTopUpValid = false;
      });
    }
  }

  Future<void> _pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          file = File(image.path);
        });
      } else {
        return;
      }
    } catch (e) {
      rethrow;
    }
  }

  void _showImage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [Image.file(file!)],
          ),
          actions: [
            CustomElevatedButton(
              color: kRedColor,
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  file = null;
                });
              },
              text: 'Cancel Upload',
            ),
            CustomElevatedButton(
              onPressed: () => Navigator.pop(context),
              text: 'Ok',
            ),
          ],
        );
      },
    );
  }

  void _topUpSaldo() async {
    if (totalTopUp != null && file != null) {
      var response = context.read<TopUpProvider>();
      await context.read<TopUpProvider>().topUp(TopUpRequestModel(totaltopup: totalTopUp!.ceil().toString(), image: file!));
      if (response.dataTopUp.statusCode == 200) {
        Timer(Duration.zero, () {
          setState(() {
            totalTopUp = null;
            file = null;
            _controller.text = '';
            isTopUpValid = false;
            isGenerate = false;
          });
          snackBar(
            context: context,
            condition: Condition.success,
            message: 'Top Up Process by ADMIN',
          );
          context.read<TopUpProvider>().refetchGetTopUpHistory(context);
        });
      } else {
        Timer(Duration.zero, () {
          snackBar(
            context: context,
            condition: Condition.failed,
            message: 'Something Error...',
          );
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              'assets/images/bca.png',
              width: Responsive.width(context, 20),
            ),
            SizedBox(width: Responsive.width(context, 2)),
            Text(
              'PT. Surya Langit Biru',
              style: TextStyle(
                fontSize: Responsive.width(context, 4),
              ),
            )
          ],
        ),
        const Divider(color: kGreyColor),
        SizedBox(height: Responsive.height(context, 1)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Account Number:'),
                Text(
                  '2027999995',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: Responsive.width(context, 7),
                  ),
                ),
              ],
            ),
            TextButton.icon(
              icon: const Icon(Iconsax.copy),
              onPressed: _copy,
              label: const Text('Copy'),
            ),
          ],
        ),
        const Divider(color: kGreyColor),
        const Text('''
    verify by ADMIN maximum up to 3 hours depending on transaction traffic or contact WA admin for immediately respond.
    ADMIN verification when we do TOP UP and IF your saldo is still available for the next transaction, no more ADMIN verification needed.'''),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: InputTextFormField(
                readOnly: isGenerate,
                keyboardType: TextInputType.number,
                label: 'Total Top Up',
                controller: _controller,
              ),
            ),
            isTopUpValid
                ? TextButton.icon(
                    icon: const Icon(Iconsax.copy),
                    onPressed: () => _copy(isTotal: true),
                    label: const Text('Copy'),
                  )
                : const SizedBox(),
          ],
        ),
        !isTopUpValid
            ? const Text(
                'Minimum Top Up Rp. 10.000',
                style: TextStyle(color: kRedColor),
              )
            : const SizedBox(),
        Row(
          children: [
            !isGenerate
                ? CustomElevatedButton(
                    onPressed: _generateUniqueCode,
                    text: 'Generate Unique Code',
                  )
                : const SizedBox(),
            SizedBox(width: Responsive.width(context, 1)),
            TextButton.icon(
              icon: const Icon(Iconsax.refresh),
              onPressed: () {
                _controller.text = '';
                setState(() {
                  isTopUpValid = false;
                  isGenerate = false;
                  totalTopUp = null;
                });
              },
              label: const Text('Refresh'),
            ),
          ],
        ),
        TextButton.icon(
          icon: file != null ? Icon(Iconsax.verify, size: Responsive.width(context, 8)) : Icon(Iconsax.gallery, size: Responsive.width(context, 8)),
          onPressed: file != null ? _showImage : _pickImage,
          label: file != null ? const Text('Open bank transfer receipt') : const Text('Upload bank transfer receipt'),
        ),
        CustomElevatedButton(
          isLoading: context.watch<TopUpProvider>().isLoadingTopUp,
          color: file == null || totalTopUp == null ? kGreyColor : kPrimaryColor,
          width: double.infinity,
          onPressed: _topUpSaldo,
          text: 'Top Up Saldo',
        ),
      ],
    );
  }
}
