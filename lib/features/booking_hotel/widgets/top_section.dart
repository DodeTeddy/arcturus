import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../constants/color.dart';
import '../../../constants/vector.dart';
import '../../../utils/responsive.dart';
import '../../home/widgets/icon_and_text.dart';
import '../models/booking_detail_model.dart';

class TopSection extends StatelessWidget {
  final BookingDetailModel data;
  const TopSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CachedNetworkImage(
          imageUrl: data.hotelLogo,
          imageBuilder: (context, imageProvider) => Container(
            width: Responsive.width(context, 35),
            height: Responsive.height(context, 10),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => Container(
            width: Responsive.width(context, 25),
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                'Loading...',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
          errorWidget: (context, url, error) => Center(
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
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.hotelName,
                style: TextStyle(
                  fontSize: Responsive.width(context, 7),
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconAndText(
                icon: Iconsax.location,
                iconColor: kRedColor,
                text: data.hotelCountry,
              ),
            ],
          ),
        )
      ],
    );
  }
}
