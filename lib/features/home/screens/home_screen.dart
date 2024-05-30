import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/responsive.dart';
import '../../../widgets/skeleton.dart';
import '../models/hotel_list_params.dart';
import '../providers/filter_section_provider.dart';
import '../providers/hotel_list_params_provider.dart';
import '../providers/hotel_list_provider.dart';
import '../providers/profile_provider.dart';
import '../utils/generate_profile_response.dart';
import 'filter_section_screen.dart';
import 'hotel_list_section_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    var params = context.read<HotelListParamsProvider>();
    params.resetParamsInit();
    context.read<FilterSectionProvider>().resetFilterInit();
    context.read<ProfileProvider>().getProfile(context);
    context.read<HotelListProvider>().setIsLastPage();
    context.read<HotelListProvider>().getHotelList(
          hotelListParams: HotelListParams(
            search: params.search,
            checkIn: params.checkIn.toString().split(' ')[0],
            checkOut: params.checkOut.toString().split(' ')[0],
            person: params.person.toString(),
            page: params.page.toString(),
            sort: params.sort,
          ),
          context: context,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var profile = context.watch<ProfileProvider>();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: profile.isLoading
                  ? Skeleton(
                      height: Responsive.height(context, 3.3),
                      width: Responsive.width(context, 50),
                    )
                  : Text(
                      profile.data.data == null
                          ? userName(null, null)
                          : userName(profile.data.data!.data.firstName, profile.data.data!.data.lastName),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.surface,
                        fontSize: Responsive.width(context, 5),
                      ),
                    ),
            ),
            const FilterSectionScreen(),
            const HotelListSectionScreen(),
          ],
        ),
      ),
    );
  }
}
