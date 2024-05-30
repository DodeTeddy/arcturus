import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/enum_response_message.dart';
import '../../home/providers/filter_section_provider.dart';
import '../providers/detail_hotel_provider.dart';

class DropdownMarket extends StatefulWidget {
  final Function(String?) onChanged;
  final String? Function(String?)? validator;
  const DropdownMarket({
    super.key,
    required this.onChanged,
    this.validator,
  });

  @override
  State<DropdownMarket> createState() => _DropdownMarketState();
}

class _DropdownMarketState extends State<DropdownMarket> {
  @override
  Widget build(BuildContext context) {
    var data = context.watch<DetailHotelProvider>();

    late List<DropdownMenuItem<String>> items = data.data.data!.market
        .map(
          (value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ),
        )
        .toList();
    return DropdownButtonFormField<String>(
      value: context.watch<FilterSectionProvider>().country.isNotEmpty ? context.watch<FilterSectionProvider>().country : null,
      hint: data.isLoading
          ? const Text('Loading...')
          : data.data.message == ResponseMessage.error || data.data.message == ResponseMessage.errorCatch
              ? Text('Error ${data.data.statusCode}')
              : null,
      items: data.isLoading || data.data.message == ResponseMessage.error || data.data.message == ResponseMessage.errorCatch ? [] : items,
      onChanged: data.isLoading || data.data.message == ResponseMessage.error || data.data.message == ResponseMessage.errorCatch ? null : widget.onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
    );
  }
}
