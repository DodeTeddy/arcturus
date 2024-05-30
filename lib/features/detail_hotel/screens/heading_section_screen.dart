import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../../constants/vector.dart';
import '../../../utils/responsive.dart';
import '../../booking_hotel/providers/booking_hotel_provider.dart';
import '../../home/providers/filter_section_provider.dart';
import '../providers/detail_hotel_provider.dart';

class HeadingSectionScreen extends StatelessWidget {
  const HeadingSectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var data = context.watch<DetailHotelProvider>();

    void onBack() {
      Navigator.pop(context);
      context.read<FilterSectionProvider>().resetFilter();
      context.read<BookingHotelProvider>().resetBookingHotel();
    }

    return Stack(
      children: [
        SizedBox(
          height: Responsive.height(context, 20),
          child: data.isLoading
              ? Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      SizedBox(width: Responsive.width(context, 5)),
                      Text(
                        'Loading...',
                        style: TextStyle(
                          fontSize: Responsive.width(context, 8),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                )
              : PageView.builder(
                  itemCount: data.data.data?.images.length,
                  itemBuilder: (context, index) {
                    var image = data.data.data?.images[index];
                    return CachedNetworkImage(
                      imageUrl: image.toString(),
                      imageBuilder: (context, imageProvider) => Container(
                        width: Responsive.width(context, 25),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Center(
                        child: Text(
                          'Loading...',
                          style: TextStyle(
                            fontSize: Responsive.width(context, 8),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Image.asset(errorVector),
                    );
                  },
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: GestureDetector(
            onTap: onBack,
            child: Icon(
              Iconsax.arrow_left,
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
        ),
      ],
    );
  }
}
