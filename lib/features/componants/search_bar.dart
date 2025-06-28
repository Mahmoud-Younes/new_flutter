import 'package:flutter/material.dart';
import 'package:new_flutter/core/widgets/contants.dart';
import 'package:new_flutter/features/Componants/my_text_form_field.dart';


// ignore: must_be_immutable
class MySearchBar extends StatelessWidget {
  MySearchBar({super.key});

  final TextEditingController _searchController = TextEditingController();
  String? valueSearch;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: MyFormField(
        controller: _searchController,
        hintText: "Search for Hotels, Cities",
        value: valueSearch,
        keyboardType: TextInputType.text,
        setIcon: true,
        icon: const Icon(
          Icons.search,
          color:kMainColor,
        ),
      ),
    );
  }
}
