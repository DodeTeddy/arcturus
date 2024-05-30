import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/vector.dart';
import '../../../utils/responsive.dart';
import '../models/hotel_list_params.dart';
import '../providers/filter_section_provider.dart';
import '../providers/hotel_list_params_provider.dart';
import '../providers/hotel_list_provider.dart';

class HotelListError extends StatelessWidget {
  final String errorText;
  const HotelListError({
    super.key,
    required this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    Future<void> onRefresh() async {
      context.read<FilterSectionProvider>().resetFilter();
      context.read<HotelListProvider>().setIsLastPage();
      var params = context.read<HotelListParamsProvider>();
      params.resetParams();
      context.read<HotelListProvider>().refetchHotelList(
            hotelListParams: HotelListParams(
              search: params.search,
              checkIn: params.checkIn.toString().split(' ')[0],
              checkOut: params.checkOut.toString().split(' ')[0],
              person: params.person.toString(),
              page: params.page.toString(),
              sort: params.sort,
            ),
          );
    }

    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          await onRefresh();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(top: Responsive.height(context, 5)),
            child: Column(
              children: [
                Image.asset(
                  errorVector,
                  width: Responsive.width(context, 50),
                ),
                Text(
                  errorText,
                  style: TextStyle(
                    fontSize: Responsive.width(context, 6),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
