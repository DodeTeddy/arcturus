import 'package:arcturus_mobile_app/features/top_up/providers/top_up_provider.dart';
import 'package:arcturus_mobile_app/routes/route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopUpScreen extends StatefulWidget {
  const TopUpScreen({super.key});

  @override
  State<TopUpScreen> createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  @override
  void initState() {
    context.read<TopUpProvider>().getTopHistory(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => !didPop ? Navigator.pushNamedAndRemoveUntil(context, mainScreen, (route) => false) : null,
      child: Scaffold(
        body: Column(
          children: [],
        ),
      ),
    );
  }
}
