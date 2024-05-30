import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../../constants/color.dart';
import '../../../constants/vector.dart';
import '../../../routes/route.dart';
import '../../../utils/currency_format.dart';
import '../../../utils/responsive.dart';
import '../../booking_hotel/providers/booking_hotel_provider.dart';
import '../../detail_hotel/models/detail_hotel_arguments.dart';
import '../models/hotel_list_params.dart';
import '../providers/filter_section_provider.dart';
import '../providers/hotel_list_params_provider.dart';
import '../providers/hotel_list_provider.dart';
import 'hotel_star.dart';
import 'icon_and_text.dart';

class HotelListItems extends StatefulWidget {
  const HotelListItems({
    super.key,
  });

  @override
  State<HotelListItems> createState() => _HotelListItemsState();
}

class _HotelListItemsState extends State<HotelListItems> {
  final ScrollController _scrollController = ScrollController();
  Future<void> _onRefresh() async {
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

  void _onPop(bool didPop) {
    if (didPop) {
      context.read<BookingHotelProvider>().resetBookingHotel();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent == _scrollController.offset) {
        if (!context.read<HotelListProvider>().isLastPage) {
          var params = context.read<HotelListParamsProvider>();
          context.read<HotelListProvider>().getHotelListNextPage(
                hotelListParams: HotelListParams(
                  search: params.search,
                  checkIn: params.checkIn.toString().split(' ')[0],
                  checkOut: params.checkOut.toString().split(' ')[0],
                  person: params.person.toString(),
                  page: (params.page + 1).toString(),
                  sort: params.sort,
                ),
              );
          context.read<HotelListParamsProvider>().setPage();
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var data = context.watch<HotelListProvider>();

    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          await _onRefresh();
        },
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
          padding: EdgeInsets.only(bottom: Responsive.width(context, 3)),
          itemCount: data.isLoading ? 0 : data.data.data.length + 1,
          itemBuilder: (context, index) {
            if (index < data.data.data.length) {
              var dataHotel = data.data.data[index];

              return PopScope(
                canPop: true,
                onPopInvoked: (didPop) => _onPop(didPop),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      detailHotelScreen,
                      arguments: DetailHotelArguments(
                        idContractrate: dataHotel.idContractrate,
                      ),
                    );
                  },
                  child: Container(
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
                        CachedNetworkImage(
                          imageUrl: dataHotel!.hotelImage,
                          imageBuilder: (context, imageProvider) => Container(
                            width: Responsive.width(context, 25),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
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
                        Container(
                          width: Responsive.width(context, 40),
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HotelStar(star: int.parse(dataHotel.hotelStar)),
                              Text(
                                dataHotel.hotelName,
                                style: TextStyle(
                                  fontSize: Responsive.width(context, 3.8),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconAndText(
                                icon: Iconsax.location,
                                iconColor: kRedColor,
                                text: dataHotel.hotelLocation,
                              ),
                              IconAndText(
                                icon: Iconsax.user,
                                iconColor: Theme.of(context).colorScheme.primary,
                                text: '${dataHotel.maxRoomPerson} Person',
                              ),
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
                                Text(
                                  CurrencyFormat.convertToIdr(double.parse(dataHotel.hotelPrice)),
                                  overflow: TextOverflow.ellipsis,
                                ),
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
                  ),
                ),
              );
            } else {
              bool isLastPage = context.watch<HotelListProvider>().isLastPage;
              bool isLoadingNextPage = context.watch<HotelListProvider>().isLoadingNextPage;
              return isLastPage || !isLoadingNextPage
                  ? null
                  : Padding(
                      padding: EdgeInsets.only(
                        top: Responsive.height(context, 1),
                      ),
                      child: Center(
                        child: Text(
                          'Loading.....',
                          style: TextStyle(color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    );
            }
          },
        ),
      ),
    );
  }
}
