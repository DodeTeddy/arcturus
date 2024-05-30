import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/color.dart';
import '../providers/show_hide_password_provider.dart';

class InputPasswordFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?) validator;
  const InputPasswordFormField({
    super.key,
    required this.label,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Consumer<ShowHidePasswordProvider>(
          builder: (_, value, __) {
            return TextFormField(
              obscureText: value.isHidePassword,
              controller: controller,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validator,
              decoration: InputDecoration(
                suffixIcon: value.isHidePassword
                    ? GestureDetector(
                        onTap: () => value.visibilityOnTap(),
                        child: const Icon(
                          Icons.visibility_rounded,
                          color: kGreyColor,
                        ),
                      )
                    : GestureDetector(
                        onTap: () => value.visibilityOnTap(),
                        child: const Icon(
                          Icons.visibility_off_rounded,
                          color: kGreyColor,
                        ),
                      ),
              ),
            );
          },
        ),
      ],
    );
  }
}
