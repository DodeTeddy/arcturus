import 'package:flutter/material.dart';

import '../../../constants/color.dart';
import '../../../utils/responsive.dart';
import '../../../widgets/skeleton.dart';

class ListRoomHotelSkeleton extends StatelessWidget {
  const ListRoomHotelSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(3, (_) {
          return Container(
            height: Responsive.height(context, 17),
            margin: EdgeInsets.symmetric(
              vertical: Responsive.height(context, 1),
              horizontal: Responsive.height(context, 1.5),
            ),
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
            child: Row(
              children: [
                SizedBox(
                  width: Responsive.width(context, 25),
                  child: Text(
                    'Loading...',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: Responsive.width(context, 4),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Skeleton(
                          height: Responsive.height(context, 2),
                          width: Responsive.width(context, 20),
                        ),
                        SizedBox(height: Responsive.height(context, 0.5)),
                        Skeleton(
                          height: Responsive.height(context, 2),
                          width: double.infinity,
                        ),
                        SizedBox(height: Responsive.height(context, 0.5)),
                        Skeleton(
                          height: Responsive.height(context, 2),
                          width: double.infinity,
                        ),
                        SizedBox(height: Responsive.height(context, 0.5)),
                        Skeleton(
                          height: Responsive.height(context, 2),
                          width: double.infinity,
                        ),
                        SizedBox(height: Responsive.height(context, 0.5)),
                        Skeleton(
                          height: Responsive.height(context, 4),
                          width: Responsive.width(context, 20),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ],
    );
  }
}
