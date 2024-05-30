import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/vector.dart';
import '../../../models/enum_response_message.dart';
import '../../../utils/responsive.dart';
import '../../home/providers/filter_section_provider.dart';
import '../models/detail_hotel_params.dart';
import '../providers/detail_hotel_provider.dart';

class DetailHotelErrorScreen extends StatelessWidget {
  final int id;
  const DetailHotelErrorScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    var data = context.watch<DetailHotelProvider>();

    Future<void> onRefresh() async {
      var params = context.read<FilterSectionProvider>();
      context.read<DetailHotelProvider>().getDetailHotel(
            id: id,
            params: DetailHotelParams(
              person: params.person.toString(),
              checkIn: params.checkIn.toString().split(' ')[0],
              checkOut: params.checkOut.toString().split(' ')[0],
              country: '',
              sort: '',
            ),
            context: context,
          );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await onRefresh();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          height: Responsive.getHeight(context),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  errorVector,
                  width: Responsive.width(context, 70),
                ),
                Text(
                  data.data.message == ResponseMessage.error ? data.data.statusCode.toString() : 'Something Error...',
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
