import 'package:arcturus_mobile_app/features/top_up/screens/top_screen.dart';

import '../features/setting/screens/bank_account_screen.dart';
import '../features/setting/screens/general_information_screen.dart';
import '../features/setting/screens/update_password_screen.dart';
import 'package:flutter/material.dart';

import '../features/account_not_active/screens/account_not_active_screen.dart';
import '../features/booking_hotel/screens/booking_hotel_screen.dart';
import '../features/detail_hotel/models/detail_hotel_arguments.dart';
import '../features/detail_hotel/screens/detail_hotel_screen.dart';
import '../features/main/screens/main_screen.dart';
import '../features/payment/screens/payment_screen.dart';
import '../features/sign_in/screens/sign_in_screen.dart';
import '../features/sign_up/screens/sign_up_screen.dart';
import '../features/splash_screen/screens/splash_screen.dart';
import '../widgets/not_found_widget.dart';
import 'route.dart';

Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case splashScreen:
      return MaterialPageRoute(builder: (context) => const SplashScreen());
    case signInScreen:
      return MaterialPageRoute(builder: (context) => const SignInScreen());
    case signUpScreen:
      return MaterialPageRoute(builder: (context) => const SignUpScreen());
    case mainScreen:
      return MaterialPageRoute(builder: (context) => const MainScreen());
    case accountNotActiveScreen:
      return MaterialPageRoute(builder: (context) => const AccountNotActiveScreen());
    case detailHotelScreen:
      final DetailHotelArguments arguments = settings.arguments as DetailHotelArguments;
      return MaterialPageRoute(builder: (context) => DetailHotelScreen(arguments: arguments));
    case bookingHotelScreen:
      final int bookingId = settings.arguments as int;
      return MaterialPageRoute(builder: (context) => BookingHotelScreen(bookingId: bookingId));
    case paymentScreen:
      final int bookingId = settings.arguments as int;
      return MaterialPageRoute(builder: (context) => PaymentScreen(bookingId: bookingId));
    case updatePasswordScreen:
      return MaterialPageRoute(builder: (context) => const UpdatePasswordScreen());
    case generalInformationScreen:
      return MaterialPageRoute(builder: (context) => const GeneralInformationScreen());
    case bankAccountScreen:
      return MaterialPageRoute(builder: (context) => const BankAccountScreen());
    case topUpScreen:
      return MaterialPageRoute(builder: (context) => const TopUpScreen());
    default:
      return MaterialPageRoute(builder: (context) => const NotFoundWidget());
  }
}
