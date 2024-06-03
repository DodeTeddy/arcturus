import 'package:arcturus_mobile_app/features/top_up/providers/top_up_provider.dart';
import 'package:arcturus_mobile_app/features/top_up/screens/form_top_up_section_screen.dart';
import 'package:arcturus_mobile_app/routes/route.dart';
import 'package:arcturus_mobile_app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class TopUpScreen extends StatefulWidget {
  const TopUpScreen({super.key});

  @override
  State<TopUpScreen> createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  void _didPop(bool didPop) {
    if (!didPop) {
      Navigator.pushNamedAndRemoveUntil(context, mainScreen, (route) => false);
      context.read<TopUpProvider>().resetProvider();
    } else {
      null;
    }
  }

  @override
  void initState() {
    context.read<TopUpProvider>().getTopUpHistory(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var data = context.watch<TopUpProvider>();
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => _didPop(didPop),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Arcturus Pay',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: Responsive.width(context, 6.5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: Responsive.height(context, 2)),
                  const FormTopUpSectionScreen(),
                  SizedBox(height: Responsive.height(context, 3)),
                  TextButton.icon(
                    icon: Icon(Iconsax.calendar_1, size: Responsive.width(context, 10)),
                    onPressed: context.watch<TopUpProvider>().isLoadingTopUp
                        ? null
                        : () => Navigator.pushNamed(
                              context,
                              topUpHistoryScreen,
                              arguments: data.data.data != null ? data.data.data!.history : [],
                            ),
                    label: Text(
                      context.watch<TopUpProvider>().isLoading ? 'Loading...' : 'Go to Top Up History Page',
                      style: TextStyle(fontSize: Responsive.width(context, 4.5), fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
