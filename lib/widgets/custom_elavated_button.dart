import 'package:flutter/material.dart';

import '../utils/responsive.dart';

class CustomElevatedButton extends StatelessWidget {
  final Function() onPressed;
  final double? height;
  final double? width;
  final bool isLoading;
  final String text;
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    this.height,
    this.width,
    this.isLoading = false,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        child: isLoading
            ? SizedBox(
                height: Responsive.height(context, 3),
                width: Responsive.width(context, 6.3),
                child: const CircularProgressIndicator(),
              )
            : Text(text),
      ),
    );
  }
}
