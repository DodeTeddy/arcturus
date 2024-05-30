import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../../constants/color.dart';
import '../../../utils/currency_format.dart';
import '../../../utils/html_parser.dart';
import '../../../utils/responsive.dart';
import '../../../widgets/custom_elavated_button.dart';
import '../../booking_hotel/providers/booking_hotel_provider.dart';
import '../models/room_params.dart';
import '../providers/detail_hotel_provider.dart';
import 'add_and_subtract_room.dart';

class BottomSheetBody extends StatefulWidget {
  final int indexRoomAvailable;
  const BottomSheetBody({super.key, required this.indexRoomAvailable});

  @override
  State<BottomSheetBody> createState() => _BottomSheetBodyState();
}

class _BottomSheetBodyState extends State<BottomSheetBody> {
  void _onAdd(RoomParams room) {
    context.read<BookingHotelProvider>().addRoom(room);
  }

  void _onCancel(RoomParams room, int index) {
    context.read<BookingHotelProvider>().removeRoom(room);
    context.read<DetailHotelProvider>().setQuantity(widget.indexRoomAvailable, index, 0);
  }

  @override
  Widget build(BuildContext context) {
    var rate = context.watch<DetailHotelProvider>().data.data!.availableRoom[widget.indexRoomAvailable].room;
    var room = context.watch<BookingHotelProvider>().room;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: Responsive.height(context, 2)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.watch<DetailHotelProvider>().data.data!.availableRoom[widget.indexRoomAvailable].roomName,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: Responsive.width(context, 6),
                fontWeight: FontWeight.bold,
              ),
            ),
            ...List.generate(
              rate.length,
              (index) {
                var data = rate[index];
                double price = double.parse(data.roomPrice) + double.parse(data.markUpPrice);

                return Container(
                  margin: EdgeInsets.symmetric(
                    vertical: Responsive.height(context, 1),
                    horizontal: Responsive.width(context, 3),
                  ),
                  padding: const EdgeInsets.all(15),
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
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: Responsive.width(context, 65),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Minimum Stay ${data.minStay} nights'),
                                Text(
                                  CurrencyFormat.convertToIdr(price),
                                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                                ),
                                Text(htmlParser(data.benefit)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: room.any((element) => element.contractId == data.contractId)
                                ? Column(
                                    children: [
                                      const Text('Cancel'),
                                      IconButton(
                                        onPressed: () => _onCancel(
                                          RoomParams(
                                            contractPriceId: data.contractPriceId,
                                            contractId: data.contractId,
                                            price: price,
                                            priceNoMarkUp: double.parse(data.roomPrice),
                                            quantity: data.quantity,
                                            roomId: data.roomId,
                                          ),
                                          index,
                                        ),
                                        icon: const Icon(
                                          Iconsax.trash,
                                          color: kRedColor,
                                        ),
                                      )
                                    ],
                                  )
                                : Column(
                                    children: [
                                      const Text('Room'),
                                      AddAndSubtractRoom(
                                        roomAllow: int.parse(data.roomAllow),
                                        roomAdd: (value) => context.read<DetailHotelProvider>().setQuantity(widget.indexRoomAvailable, index, value),
                                      ),
                                    ],
                                  ),
                          ),
                        ],
                      ),
                      data.quantity == 0 || room.any((element) => element.contractId == data.contractId)
                          ? const SizedBox()
                          : CustomElevatedButton(
                              width: double.infinity,
                              onPressed: () => _onAdd(
                                RoomParams(
                                  contractPriceId: data.contractPriceId,
                                  contractId: data.contractId,
                                  price: price,
                                  priceNoMarkUp: double.parse(data.roomPrice),
                                  quantity: data.quantity,
                                  roomId: data.roomId,
                                ),
                              ),
                              text: 'Add',
                            ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
