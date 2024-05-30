import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/color.dart';
import '../../../constants/vector.dart';
import '../../../utils/html_parser.dart';
import '../../../utils/responsive.dart';
import '../../../widgets/custom_elavated_button.dart';
import '../providers/detail_hotel_provider.dart';
import '../widgets/list_room_hotel_skeleton.dart';

class ListRoomHotelScreen extends StatelessWidget {
  final Function(int) viewRates;
  const ListRoomHotelScreen({super.key, required this.viewRates});

  @override
  Widget build(BuildContext context) {
    var data = context.watch<DetailHotelProvider>();

    return data.isLoading
        ? const ListRoomHotelSkeleton()
        : Column(
            children: [
              ...List.generate(
                data.data.data == null ? 0 : data.data.data!.availableRoom.length,
                (index) {
                  var room = data.data.data!.availableRoom[index];
                  return room.room.isNotEmpty
                      ? Container(
                          height: Responsive.height(context, 17),
                          margin: EdgeInsets.symmetric(
                            vertical: Responsive.height(context, 1),
                            horizontal: Responsive.height(context, 1.5),
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
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl: room.roomImage,
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
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        room.roomName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        htmlParser(room.roomExplanation),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                      ),
                                      CustomElevatedButton(
                                        onPressed: () => viewRates(index),
                                        text: 'View Rates',
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : const SizedBox();
                },
              ),
            ],
          );
  }
}
