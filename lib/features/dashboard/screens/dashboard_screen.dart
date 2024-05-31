import 'package:arcturus_mobile_app/features/dashboard/providers/dashboard_provider.dart';
import 'package:arcturus_mobile_app/features/dashboard/screens/booking_report_screen.dart';
import 'package:arcturus_mobile_app/features/dashboard/screens/info_section_screen.dart';
import 'package:arcturus_mobile_app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'saldo_section_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    context.read<DashboardProvider>().getDashboardData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              'Agent Dashboard',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: Responsive.width(context, 6),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Responsive.height(context, 1)),
            const SaldoSectionScreen(),
            SizedBox(height: Responsive.height(context, 2)),
            const InfoSectionScreen(),
            SizedBox(height: Responsive.height(context, 2)),
            const BookingReportScreen(),
          ],
        ),
      ),
    );
  }
}
