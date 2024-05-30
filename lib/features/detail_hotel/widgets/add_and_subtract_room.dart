import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AddAndSubtractRoom extends StatefulWidget {
  final int roomAllow;
  final Function(int) roomAdd;
  const AddAndSubtractRoom({super.key, required this.roomAllow, required this.roomAdd});

  @override
  State<AddAndSubtractRoom> createState() => _AddAndSubtractRoomState();
}

class _AddAndSubtractRoomState extends State<AddAndSubtractRoom> {
  int room = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              if (room > 0) {
                room--;
              }
            });
            widget.roomAdd(room);
          },
          child: Icon(
            Iconsax.minus,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Text(room.toString()),
        GestureDetector(
          onTap: () {
            setState(() {
              if (room < widget.roomAllow) {
                room++;
              }
            });
            widget.roomAdd(room);
          },
          child: Icon(
            Iconsax.add,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
