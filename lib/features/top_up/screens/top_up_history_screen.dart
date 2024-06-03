import 'package:arcturus_mobile_app/features/top_up/models/top_up_model.dart';
import 'package:arcturus_mobile_app/features/top_up/widgets/history_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/color.dart';
import '../../../utils/responsive.dart';

class TopUpHistoryScreen extends StatelessWidget {
  final List<History> data;
  const TopUpHistoryScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var history = data;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'History',
          style: TextStyle(fontSize: Responsive.width(context, 5)),
        ),
        iconTheme: const IconThemeData(
          color: kWhiteColor,
        ),
      ),
      body: history.isNotEmpty
          ? ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: kGreyColor,
                        offset: Offset(0, 2),
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            history[index].typeTransaction == 'TOP-UP-SALDO' ? 'TOP UP' : 'PAYMENT',
                            style: TextStyle(
                              color: history[index].typeTransaction == 'TOP-UP-SALDO' ? kGreenColor : kRedColor,
                              fontSize: Responsive.width(context, 5),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: Responsive.width(context, 1.5)),
                          Text(
                            DateFormat('yyyy-MM-dd').format(history[index].createdAt),
                            style: TextStyle(
                              color: history[index].typeTransaction == 'TOP-UP-SALDO' ? kGreenColor : kRedColor,
                              fontSize: Responsive.width(context, 5),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Responsive.height(context, 2)),
                      HistoryItem(
                        color: Theme.of(context).colorScheme.primary,
                        label: history[index].typeTransaction == 'TOP-UP-SALDO' ? 'Saldo Before Top Up' : 'Saldo Before Payment',
                        value: double.parse(history[index].saldoMaster!),
                      ),
                      HistoryItem(
                        color: history[index].typeTransaction == 'TOP-UP-SALDO' ? kGreenColor : kRedColor,
                        label: history[index].typeTransaction == 'TOP-UP-SALDO' ? 'Top Up' : 'Payment',
                        value: double.parse(history[index].saldoAddMinus!),
                      ),
                      HistoryItem(
                        color: Theme.of(context).colorScheme.primary,
                        label: history[index].typeTransaction == 'TOP-UP-SALDO' ? 'Saldo After Top Up' : 'Saldo After Payment',
                        value: double.parse(history[index].totalSaldo!),
                      ),
                      SizedBox(height: Responsive.height(context, 2)),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: history[index].status! == 'proccessing' ? Colors.amber : kGreenColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          history[index].status!.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kWhiteColor,
                            fontSize: Responsive.width(context, 4),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                );
              },
            )
          : Center(
              child: Text(
                'Data History is Empty!',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: Responsive.width(context, 5),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }
}
