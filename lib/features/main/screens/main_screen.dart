import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../dashboard/screens/dashboard_screen.dart';
import '../../home/screens/home_screen.dart';
import '../../setting/screens/setting_screen.dart';
import '../providers/nav_bar_provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var currentIndex = context.watch<NavBarProvider>().pageIndex;
    var onChangeNavBar = context.watch<NavBarProvider>().onChangeNavBar;

    List<BottomNavigationBarItem> items = [
      const BottomNavigationBarItem(
        label: 'Home',
        icon: Icon(Iconsax.home),
      ),
      const BottomNavigationBarItem(
        label: 'Dashboard',
        icon: Icon(Iconsax.document),
      ),
      const BottomNavigationBarItem(
        label: 'Setting',
        icon: Icon(Iconsax.setting),
      )
    ];

    Widget body() {
      switch (currentIndex) {
        case 1:
          return const DashboardScreen();

        case 2:
          return const SettingScreen();

        default:
          return const HomeScreen();
      }
    }

    return Scaffold(
      body: body(),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 8,
        currentIndex: currentIndex,
        items: items,
        onTap: (pageIndex) => onChangeNavBar(pageIndex),
      ),
    );
  }
}
