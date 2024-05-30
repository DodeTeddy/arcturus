import 'dart:async';

import 'package:flutter/material.dart';

import '../../../constants/key.dart';
import '../../../constants/vector.dart';
import '../../../routes/route.dart';
import '../../../utils/secure_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void navigation() async {
    var status = await SecureStorage().readSecureData(signInStatus);
    var active = await SecureStorage().readSecureData(accountActiveStatus);

    if (status == 'true' && active == '1') {
      Timer(Duration.zero, () {
        Navigator.pushNamedAndRemoveUntil(context, mainScreen, (route) => false);
      });
    } else if (status == 'true' && active == '0') {
      Timer(Duration.zero, () {
        Navigator.pushNamedAndRemoveUntil(context, accountNotActiveScreen, (route) => false);
      });
    } else {
      Timer(Duration.zero, () {
        Navigator.pushNamedAndRemoveUntil(context, signInScreen, (route) => false);
      });
    }
  }

  @override
  void initState() {
    Timer(
      const Duration(milliseconds: 3000),
      navigation,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(arcturusLogo),
      ),
    );
  }
}
