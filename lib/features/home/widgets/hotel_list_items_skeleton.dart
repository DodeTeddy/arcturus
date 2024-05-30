import 'package:flutter/material.dart';

import '../../../constants/color.dart';
import '../../../constants/vector.dart';
import '../../../utils/responsive.dart';
import '../../../widgets/skeleton.dart';

class HotelListItemsSkeleton extends StatelessWidget {
  const HotelListItemsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            height: Responsive.height(context, 13),
            margin: EdgeInsets.only(
              top: Responsive.height(context, 1),
              left: Responsive.width(context, 1),
              right: Responsive.width(context, 1),
              bottom: Responsive.height(context, 0.5),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: const [
                BoxShadow(
                  color: kGreyColor,
                  offset: Offset(0, 2),
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: Responsive.height(context, 10),
                    width: Responsive.width(context, 25),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(errorVector),
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: Responsive.width(context, 42),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Skeleton(height: Responsive.height(context, 2), width: Responsive.width(context, 20)),
                      SizedBox(height: Responsive.height(context, 0.5)),
                      Skeleton(height: Responsive.height(context, 2), width: Responsive.width(context, 20)),
                      SizedBox(height: Responsive.height(context, 0.5)),
                      Skeleton(height: Responsive.height(context, 1.5), width: Responsive.width(context, 40)),
                      SizedBox(height: Responsive.height(context, 1)),
                      Skeleton(height: Responsive.height(context, 1.5), width: Responsive.width(context, 20)),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(width: 3, color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'From',
                          overflow: TextOverflow.ellipsis,
                        ),
                        Skeleton(height: Responsive.height(context, 1.5), width: Responsive.width(context, 20)),
                        const Text(
                          '/Night',
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
