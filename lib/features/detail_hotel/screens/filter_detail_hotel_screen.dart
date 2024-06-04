import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../../constants/color.dart';
import '../../../utils/responsive.dart';
import '../../../widgets/custom_elavated_button.dart';
import '../../../widgets/skeleton.dart';
import '../../home/providers/filter_section_provider.dart';
import '../../home/widgets/date_picker.dart';
import '../../home/widgets/hotel_star.dart';
import '../../home/widgets/icon_and_text.dart';
import '../../home/widgets/person_field.dart';
import '../models/detail_hotel_params.dart';
import '../providers/detail_hotel_provider.dart';
import '../providers/hotel_highlight_provider.dart';
import '../widgets/dropdown_market.dart';

class FilterDetailHotelScreen extends StatelessWidget {
  final int id;
  const FilterDetailHotelScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    var params = context.watch<FilterSectionProvider>();
    var data = context.watch<DetailHotelProvider>();

    void onPressedSearch() {
      context.read<DetailHotelProvider>().refetchDetailHotel(
            id: id,
            params: DetailHotelParams(
              person: params.person.toString(),
              checkIn: params.checkIn.toString().split(' ')[0],
              checkOut: params.checkOut.toString().split(' ')[0],
              country: params.country,
              sort: '',
            ),
            context: context,
          );
    }

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Responsive.width(context, 3),
      ),
      padding: EdgeInsets.symmetric(
        vertical: Responsive.height(context, 1),
        horizontal: Responsive.width(context, 3),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          data.isLoading
              ? Skeleton(height: Responsive.height(context, 2), width: Responsive.width(context, 30))
              : HotelStar(star: int.parse(data.data.data!.hotelStar.isNotEmpty ? data.data.data!.hotelStar : "0")),
          SizedBox(height: Responsive.height(context, 0.5)),
          data.isLoading
              ? Skeleton(height: Responsive.height(context, 2.5), width: Responsive.width(context, 30))
              : Text(
                  data.data.data!.hotelName,
                  style: TextStyle(
                    fontSize: Responsive.width(context, 5),
                    fontWeight: FontWeight.bold,
                  ),
                ),
          SizedBox(height: Responsive.height(context, 0.5)),
          data.isLoading
              ? Skeleton(height: Responsive.height(context, 1), width: Responsive.width(context, 15))
              : IconAndText(icon: Iconsax.location, text: data.data.data!.hotelCountry),
          SizedBox(height: Responsive.height(context, 0.5)),
          data.isLoading
              ? Column(
                  children: [
                    Skeleton(height: Responsive.height(context, 1.5), width: double.infinity),
                    SizedBox(height: Responsive.height(context, 0.5)),
                    Skeleton(height: Responsive.height(context, 1.5), width: double.infinity),
                  ],
                )
              : GestureDetector(
                  onTap: () => context.read<HotelHighlightProvider>().setIsExpand(),
                  child: SizedBox(
                    height: context.watch<HotelHighlightProvider>().isExpand ? null : Responsive.height(context, 5),
                    child: Text(
                      data.data.data!.hotelHighlights,
                      overflow: context.watch<HotelHighlightProvider>().isExpand ? null : TextOverflow.ellipsis,
                    ),
                  ),
                ),
          if (!data.isLoading && data.data.data!.market.isNotEmpty)
            DropdownMarket(
              onChanged: (value) => context.read<FilterSectionProvider>().setCountry(value.toString()),
            ),
          if (!data.isLoading && data.data.data!.market.isNotEmpty)
            const Text(
              '* Guest ID Card = Market, ID Card is required upon check-in',
              style: TextStyle(
                color: kRedColor,
              ),
            ),
          SizedBox(height: Responsive.height(context, 1)),
          Row(
            children: [
              Expanded(
                child: DatePicker(
                    initialDate: params.checkIn,
                    firstDate: params.checkIn,
                    text: params.checkIn.toString().split(" ")[0],
                    onChanged: (value) {
                      context.read<FilterSectionProvider>().setCheckIn(value);
                      context.read<FilterSectionProvider>().setCheckOut(DateTime(params.checkIn.year, params.checkIn.month, params.checkIn.day + 1));
                    }),
              ),
              SizedBox(
                width: Responsive.width(context, 2),
              ),
              Expanded(
                child: DatePicker(
                  initialDate: DateTime(params.checkIn.year, params.checkIn.month, params.checkIn.day + 1),
                  firstDate: DateTime(params.checkIn.year, params.checkIn.month, params.checkIn.day + 1),
                  text: params.checkOut.toString().split(" ")[0],
                  onChanged: (value) => context.read<FilterSectionProvider>().setCheckOut(value),
                ),
              ),
            ],
          ),
          SizedBox(height: Responsive.height(context, 1)),
          PersonField(onChanged: (value) => context.read<FilterSectionProvider>().setPerson(value)),
          SizedBox(height: Responsive.height(context, 1)),
          CustomElevatedButton(
            height: Responsive.height(context, 5),
            width: Responsive.getWidth(context),
            onPressed: onPressedSearch,
            text: 'Search',
          ),
        ],
      ),
    );
  }
}
