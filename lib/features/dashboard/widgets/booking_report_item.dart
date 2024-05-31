import 'package:arcturus_mobile_app/utils/responsive.dart';
import 'package:flutter/material.dart';

import '../../../constants/color.dart';
import '../models/item_model.dart';

class BookingReportItem extends StatelessWidget {
  final List<ItemModel> item;
  final Widget children;
  const BookingReportItem({super.key, required this.item, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Responsive.height(context, 0.5), horizontal: Responsive.width(context, 1.5)),
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
          ...List.generate(
            item.length,
            (index) {
              return Row(
                children: [
                  Expanded(
                    child: Text(item[index].item, style: TextStyle(fontSize: Responsive.width(context, 4))),
                  ),
                  SizedBox(
                    width: Responsive.width(context, 10),
                    child: const Center(child: Text(':')),
                  ),
                  Expanded(
                    child: Text(item[index].itemValue),
                  ),
                ],
              );
            },
          ),
          children,
        ],
      ),
    );
  }
}
