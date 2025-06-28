// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:new_flutter/core/widgets/contants.dart';

class GenderDropDown extends StatefulWidget {
  GenderDropDown({
    Key? key,
    required this.hint,
    required this.items,
    required this.labelText,
    this.dropdownColor = const Color(0xffF1F5F9),
  }) : super(key: key);

  String hint, labelText;
  List items;
  Color dropdownColor;
  static var selectedValue;

  @override
  State<GenderDropDown> createState() => _GenderDropDownState();
}

class _GenderDropDownState extends State<GenderDropDown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            widget.labelText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField(
            hint: Text(
              widget.hint,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            items: widget.items
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e.toString(),
                        style: const TextStyle(
                            color: Color(0xff0F172A),
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ))
                .toList(),
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: kMainColor,
              size: 33,
            ),
            dropdownColor: const Color(0xffF1F5F9),
            borderRadius: BorderRadius.circular(12),
            onChanged: (val) {
              setState(() {
                GenderDropDown.selectedValue = val;
              });
            },
            value: GenderDropDown.selectedValue,
            validator: (value) =>
                value == null ? 'This field is required' : null,
            //decoration
            decoration: InputDecoration(
              filled: true,
              fillColor: widget.dropdownColor,
              ///////////////////////
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 0),
              ),
              ///////////////////////
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: kMainColor, width: 2),
              ),
              /////////////////////////////////
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: Color(0xffDE0A1E), width: 2),
              ),
              ///////////////////////////////////
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: Color(0xffDE0A1E), width: 2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class LocationDropDown extends StatefulWidget {
  LocationDropDown({
    Key? key,
    required this.hint,
    required this.items,
    required this.labelText,
    this.dropdownColor = const Color(0xffF1F5F9),
  }) : super(key: key);

  String hint, labelText;
  List items;
  Color dropdownColor;
  static var selectedValue;

  @override
  State<LocationDropDown> createState() => _LocationDropDownState();
}

class _LocationDropDownState extends State<LocationDropDown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            widget.labelText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField(
            hint: Text(
              widget.hint,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            items: widget.items
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e.toString(),
                        style: const TextStyle(
                            color: Color(0xff0F172A),
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ))
                .toList(),
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: kMainColor,
              size: 33,
            ),
            dropdownColor: const Color(0xffF1F5F9),
            borderRadius: BorderRadius.circular(12),
            onChanged: (val) {
              setState(() {
                LocationDropDown.selectedValue = val;
              });
            },
            value: LocationDropDown.selectedValue,
            validator: (value) =>
                value == null ? 'This field is required' : null,
            //decoration
            decoration: InputDecoration(
              filled: true,
              fillColor: widget.dropdownColor,
              ///////////////////////
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 0),
              ),
              ///////////////////////
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color:kMainColor, width: 2),
              ),
              /////////////////////////////////
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: Color(0xffDE0A1E), width: 2),
              ),
              ///////////////////////////////////
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: Color(0xffDE0A1E), width: 2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
