import 'package:flutter/material.dart';

class InputTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool readOnly;
  const InputTextFormField({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
    this.keyboardType,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        TextFormField(
          readOnly: readOnly,
          keyboardType: keyboardType,
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
        ),
      ],
    );
  }
}
