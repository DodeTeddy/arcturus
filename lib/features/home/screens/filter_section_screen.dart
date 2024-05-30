import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/responsive.dart';
import '../../../widgets/custom_elavated_button.dart';
import '../models/hotel_list_params.dart';
import '../providers/filter_section_provider.dart';
import '../providers/hotel_list_params_provider.dart';
import '../providers/hotel_list_provider.dart';
import '../widgets/date_picker.dart';
import '../widgets/person_field.dart';

class FilterSectionScreen extends StatefulWidget {
  const FilterSectionScreen({super.key});

  @override
  State<FilterSectionScreen> createState() => _FilterSectionScreenState();
}

class _FilterSectionScreenState extends State<FilterSectionScreen> {
  final TextEditingController _searchController = TextEditingController();
  void onPressedSearch() {
    var params = context.read<FilterSectionProvider>();
    context.read<HotelListParamsProvider>().resetParams();
    context.read<HotelListProvider>().refetchHotelList(
          hotelListParams: HotelListParams(
            search: params.search,
            checkIn: params.checkIn.toString().split(" ")[0],
            checkOut: params.checkOut.toString().split(" ")[0],
            person: params.person.toString(),
            page: '1',
            sort: '',
          ),
        );
    context.read<HotelListParamsProvider>().setSearch(params.search);
    context.read<HotelListParamsProvider>().setCheckIn(params.checkIn);
    context.read<HotelListParamsProvider>().setCheckOut(params.checkOut);
    context.read<HotelListParamsProvider>().setPerson(params.person);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var params = context.watch<FilterSectionProvider>();
    return Container(
      margin: EdgeInsets.only(
        left: Responsive.width(context, 3),
        right: Responsive.width(context, 3),
        bottom: Responsive.height(context, 3),
      ),
      padding: EdgeInsets.symmetric(
        vertical: Responsive.height(context, 2),
        horizontal: Responsive.width(context, 3),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          TextField(
            controller: _searchController..text = params.search,
            decoration: const InputDecoration(
              hintText: 'Search...',
            ),
            onChanged: (value) => context.read<FilterSectionProvider>().setSearch(value),
          ),
          SizedBox(height: Responsive.height(context, 1.5)),
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
          SizedBox(
            height: Responsive.height(context, 1.5),
          ),
          PersonField(
            onChanged: (value) => context.read<FilterSectionProvider>().setPerson(value),
          ),
          SizedBox(
            height: Responsive.height(context, 1.5),
          ),
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
