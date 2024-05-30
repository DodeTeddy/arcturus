import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/enum_response_message.dart';
import '../models/dropdown_country_model.dart';
import '../providers/country_provider.dart';

class DropdownCountry extends StatefulWidget {
  final Function(DropdownCountryModel?) onChanged;
  final String? Function(DropdownCountryModel?)? validator;
  const DropdownCountry({
    super.key,
    required this.onChanged,
    this.validator,
  });

  @override
  State<DropdownCountry> createState() => _DropdownCountryState();
}

class _DropdownCountryState extends State<DropdownCountry> {
  @override
  void initState() {
    context.read<CountryProvider>().getCountryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var data = context.watch<CountryProvider>();

    late List<DropdownMenuItem<DropdownCountryModel>> items = data.data.data
        .map(
          (value) => DropdownMenuItem<DropdownCountryModel>(
            value: value,
            child: Text(value!.label),
          ),
        )
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Country'),
        DropdownButtonFormField<DropdownCountryModel>(
          isExpanded: true,
          hint: data.isLoading
              ? const Text('Loading...')
              : data.data.message == ResponseMessage.error || data.data.message == ResponseMessage.errorCatch
                  ? Text('Error ${data.data.statusCode}')
                  : null,
          items: data.isLoading || data.data.message == ResponseMessage.error || data.data.message == ResponseMessage.errorCatch ? [] : items,
          onChanged: data.isLoading || data.data.message == ResponseMessage.error || data.data.message == ResponseMessage.errorCatch
              ? null
              : widget.onChanged,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: widget.validator,
        ),
      ],
    );
  }
}
