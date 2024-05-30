import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../../constants/color.dart';
import '../../../constants/vector.dart';
import '../../../models/enum_condition.dart';
import '../../../routes/route.dart';
import '../../../utils/currency_format.dart';
import '../../../utils/responsive.dart';
import '../../../utils/snack_bar.dart';
import '../../../widgets/custom_elavated_button.dart';
import '../providers/payment_provider.dart';

class PaymentScreen extends StatefulWidget {
  final int bookingId;
  const PaymentScreen({super.key, required this.bookingId});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  void _onPop(bool didPop) async {
    if (!didPop) {
      Navigator.pushNamedAndRemoveUntil(context, mainScreen, (route) => false);
    }
  }

  void _checkPayProgress() {
    var response = context.read<PaymentProvider>().pay;

    if (response.statusCode == 200) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Iconsax.verify,
                  size: Responsive.width(context, 25),
                  color: kGreenColor,
                ),
                Text(
                  'Payment Success',
                  style: TextStyle(
                    fontSize: Responsive.width(context, 4),
                  ),
                ),
              ],
            ),
            actions: [
              CustomElevatedButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(context, mainScreen, (route) => false),
                text: 'Oke',
              ),
            ],
          );
        },
      );
    } else {
      snackBar(
        context: context,
        condition: Condition.failed,
        message: 'Error ${response.statusCode}',
      );
    }
  }

  void _pay() async {
    await context.read<PaymentProvider>().payment(widget.bookingId, context);
    _checkPayProgress();
  }

  @override
  void initState() {
    context.read<PaymentProvider>().fetchTotalPayment(widget.bookingId, context);
    context.read<PaymentProvider>().fetchSaldo(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var payment = context.watch<PaymentProvider>();

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => _onPop(didPop),
      child: Scaffold(
        body: payment.isLoadingSaldo || payment.isLoadingTotal
            ? Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
            : payment.saldo.statusCode == 200 && payment.totalPayment.statusCode == 200
                ? SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Responsive.width(context, 3)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Payment',
                            style: TextStyle(
                              fontSize: Responsive.width(context, 7),
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          SizedBox(height: Responsive.height(context, 10)),
                          Image.asset(
                            checkEmail,
                            width: Responsive.width(context, 80),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      'Your Saldo',
                                      style: TextStyle(
                                        fontSize: Responsive.width(context, 5),
                                      ),
                                    ),
                                    Text(
                                      payment.isLoadingSaldo
                                          ? 'Loading...'
                                          : CurrencyFormat.convertToIdr(
                                              double.parse(payment.saldo.data != null ? payment.saldo.data!.data.saldo : '0')),
                                      style: TextStyle(
                                        fontSize: Responsive.width(context, 5),
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      'Total Payment',
                                      style: TextStyle(
                                        fontSize: Responsive.width(context, 5),
                                      ),
                                    ),
                                    Text(
                                      payment.isLoadingSaldo
                                          ? 'Loading...'
                                          : CurrencyFormat.convertToIdr(double.parse(payment.totalPayment.data!.booking.price)),
                                      style: TextStyle(
                                        fontSize: Responsive.width(context, 5),
                                        fontWeight: FontWeight.bold,
                                        color: kRedColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Responsive.width(context, 5)),
                          if (double.parse(payment.isLoadingSaldo ? '0' : payment.saldo.data!.data.saldo) <
                              double.parse(payment.isLoadingTotal ? '0' : payment.totalPayment.data!.booking.price))
                            CustomElevatedButton(
                              onPressed: () {},
                              text: 'Top Up',
                            ),
                          if (double.parse(payment.isLoadingSaldo ? '0' : payment.saldo.data!.data.saldo) >
                              double.parse(payment.isLoadingTotal ? '0' : payment.totalPayment.data!.booking.price))
                            CustomElevatedButton(
                              isLoading: context.watch<PaymentProvider>().isLoadingPay,
                              onPressed: _pay,
                              text: 'Pay',
                            )
                        ],
                      ),
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          errorVector,
                          width: Responsive.width(context, 50),
                        ),
                        const Text('Something Error...'),
                      ],
                    ),
                  ),
      ),
    );
  }
}
