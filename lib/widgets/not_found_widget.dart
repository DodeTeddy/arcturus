import 'package:flutter/material.dart';

import '../constants/vector.dart';
import '../utils/responsive.dart';

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              errorVector,
              width: Responsive.width(context, 80),
            ),
            Text(
              'Page Not Found',
              style: TextStyle(
                fontSize: Responsive.width(context, 5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
