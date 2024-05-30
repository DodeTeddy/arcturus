import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../providers/filter_section_provider.dart';

class PersonField extends StatefulWidget {
  final Function(int) onChanged;
  const PersonField({
    super.key,
    required this.onChanged,
  });

  @override
  State<PersonField> createState() => _PersonFieldState();
}

class _PersonFieldState extends State<PersonField> {
  void onTapAdd() {
    var person = context.read<FilterSectionProvider>().person;
    if (person < 5) {
      setState(() {
        person++;
      });
      widget.onChanged(person);
    }
  }

  void onTapReduce() {
    var person = context.read<FilterSectionProvider>().person;
    if (person > 1) {
      setState(() {
        person--;
      });
      widget.onChanged(person);
    }
  }

  @override
  Widget build(BuildContext context) {
    var person = context.watch<FilterSectionProvider>().person;
    return TextField(
      readOnly: true,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: '$person Person',
        suffixIcon: GestureDetector(
          onTap: onTapAdd,
          child: const Icon(Iconsax.add),
        ),
        suffixIconColor: Theme.of(context).colorScheme.primary,
        prefixIcon: GestureDetector(
          onTap: onTapReduce,
          child: const Icon(Iconsax.minus),
        ),
        prefixIconColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
