import 'package:arcturus_mobile_app/features/dashboard/providers/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'features/account_not_active/providers/launch_url_provider.dart';
import 'features/booking_hotel/providers/add_transport_provider.dart';
import 'features/booking_hotel/providers/booking_detail_hotel_provider.dart';
import 'features/booking_hotel/providers/booking_hotel_provider.dart';
import 'features/booking_hotel/providers/booking_store_provider.dart';
import 'features/booking_hotel/providers/show_booking_info_provider.dart';
import 'features/detail_hotel/providers/detail_hotel_provider.dart';
import 'features/detail_hotel/providers/hotel_highlight_provider.dart';
import 'features/home/providers/filter_section_provider.dart';
import 'features/home/providers/hotel_list_params_provider.dart';
import 'features/home/providers/hotel_list_provider.dart';
import 'features/home/providers/profile_provider.dart';
import 'features/main/providers/nav_bar_provider.dart';
import 'features/payment/providers/payment_provider.dart';
import 'features/setting/providers/setting_provider.dart';
import 'features/sign_in/providers/show_hide_password_provider.dart';
import 'features/sign_in/providers/sign_in_provider.dart';
import 'features/sign_up/providers/country_provider.dart';
import 'features/sign_up/providers/sign_up_provider.dart';
import 'routes/on_generate_route.dart';
import 'routes/route.dart';
import 'themes/light_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) => runApp(
      GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ShowHidePasswordProvider()),
        ChangeNotifierProvider(create: (context) => CountryProvider()),
        ChangeNotifierProvider(create: (context) => SignUpProvider()),
        ChangeNotifierProvider(create: (context) => SignInProvider()),
        ChangeNotifierProvider(create: (context) => NavBarProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => LaunchUrlProvider()),
        ChangeNotifierProvider(create: (context) => HotelListProvider()),
        ChangeNotifierProvider(create: (context) => HotelListParamsProvider()),
        ChangeNotifierProvider(create: (context) => FilterSectionProvider()),
        ChangeNotifierProvider(create: (context) => DetailHotelProvider()),
        ChangeNotifierProvider(create: (context) => HotelHighlightProvider()),
        ChangeNotifierProvider(create: (context) => BookingHotelProvider()),
        ChangeNotifierProvider(create: (context) => BookingDetailProvider()),
        ChangeNotifierProvider(create: (context) => BookingStoreProvider()),
        ChangeNotifierProvider(create: (context) => ShowBookingInfoProvider()),
        ChangeNotifierProvider(create: (context) => AddTransportProvider()),
        ChangeNotifierProvider(create: (context) => PaymentProvider()),
        ChangeNotifierProvider(create: (context) => SettingProvider()),
        ChangeNotifierProvider(create: (context) => DashboardProvider()),
      ],
      child: MaterialApp(
        title: 'Arcturus Mobile App',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        onGenerateRoute: onGenerateRoute,
        initialRoute: splashScreen,
      ),
    );
  }
}
