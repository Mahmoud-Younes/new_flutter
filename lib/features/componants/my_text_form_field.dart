// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:new_flutter/core/widgets/contants.dart';

class MyFormField extends StatelessWidget {
  MyFormField({
    Key? key,
    required this.controller,
    this.obscureText = false,
    this.setIcon = false,
    required this.hintText,
    required this.value,
    required this.keyboardType,
    this.icon,
    this.suffix,
    this.textInputAction = TextInputAction.next,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  String? value;
  String? Function(String?)? validator;
  bool obscureText;
  final String hintText;
  final TextInputType keyboardType;

  final Widget? icon;
  bool setIcon;
  final Widget? suffix;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: ((val) {
        value = val;
      }),
      onSaved: ((val) {
        value = val;
      }),
      validator: validator,
      textInputAction: textInputAction,
      cursorColor:kMainColor,
      keyboardType: keyboardType,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        /////////////////////////////
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: 2),
          borderRadius: BorderRadius.circular(15.0),
        ),
        /////////////////////////////
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color:const Color.fromARGB(174, 252, 192, 73).withOpacity(0.75), width: 2),
          borderRadius: BorderRadius.circular(15.0),
        ),
        /////////////////////////////
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffDE0A1E), width: 2),
          borderRadius: BorderRadius.circular(15.0),
        ),
        /////////////////////////////
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffDE0A1E), width: 2),
          borderRadius: BorderRadius.circular(15.0),
        ),
        /////////////////////////////
        filled: true,
        fillColor: Colors.white,
        prefixIcon: setIcon
            ? Padding(
                padding: const EdgeInsets.all(10.5),
                child: icon,
              )
            : null,
        suffixIcon: suffix,
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 16,
          color: Colors.black.withOpacity(0.30),
        ),
      ),
    );
  }
}

class MapsFormField extends StatelessWidget {
  MapsFormField({
    Key? key,
    required this.controller,
    required this.value,
    required this.labelText,
    this.textInputAction = TextInputAction.next,
    required this.hintText,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  String? value;
  String? Function(String?)? validator;
  final String hintText, labelText;

  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //width: 90,
      //height: 60,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              labelText,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
            onFieldSubmitted: ((val) {
              value = val;
            }),
            onSaved: ((val) {
              value = val;
            }),
            validator: validator,
            textInputAction: textInputAction,
            keyboardType: TextInputType.phone,
            controller: controller,
            decoration: InputDecoration(
              /////////////////////////////
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 2),
                borderRadius: BorderRadius.circular(15.0),
              ),
              /////////////////////////////
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(15.0),
              ),
              /////////////////////////////
              errorBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xffDE0A1E), width: 2),
                borderRadius: BorderRadius.circular(15.0),
              ),
              /////////////////////////////
              focusedErrorBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xffDE0A1E), width: 2),
                borderRadius: BorderRadius.circular(15.0),
              ),
              /////////////////////////////
              filled: true,
              fillColor: const Color(0xff0F172A),
              hintText: hintText,
              hintStyle: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
