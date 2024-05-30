import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/enum_response_message.dart';
import '../models/hotel_list_params.dart';
import '../providers/hotel_list_params_provider.dart';
import '../providers/hotel_list_provider.dart';
import '../widgets/hotel_header_list.dart';
import '../widgets/hotel_list_container.dart';
import '../widgets/hotel_list_error.dart';
import '../widgets/hotel_list_items.dart';
import '../widgets/hotel_list_items_skeleton.dart';

class HotelListSectionScreen extends StatelessWidget {
  const HotelListSectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var data = context.watch<HotelListProvider>();

    void onChangeSort(String value) {
      var params = context.read<HotelListParamsProvider>();
      params.setSort(value);
      if (params.sort.isNotEmpty) {
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
    }

    return HotelListContainer(
      children: [
        HotelHeaderList(onChangeSort: (value) => onChangeSort(value)),
        data.isLoading
            ? const HotelListItemsSkeleton()
            : data.data.message == ResponseMessage.error || data.data.message == ResponseMessage.errorCatch
                ? HotelListError(
                    errorText: data.data.message == ResponseMessage.error ? 'Error ${data.data.statusCode}' : 'Something Error...',
                  )
                : data.data.data.isEmpty
                    ? const HotelListError(errorText: 'Tidak ada data!')
                    : const HotelListItems(),
      ],
    );
  }
}
