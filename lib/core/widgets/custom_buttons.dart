// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:new_flutter/core/utils/size_config.dart';
import 'package:new_flutter/core/widgets/contants.dart';
import 'package:new_flutter/core/widgets/space_widget.dart';

class CustomGeneralButton extends StatelessWidget {
  const CustomGeneralButton(
      {super.key,
      required this.text,
      required this.onTap,
      required Color color,
      });
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: Sizeconfig.screenwidth,
        decoration: BoxDecoration(
            color: kMainColor, borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: Text(
          text,
          style: const TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
          textAlign: TextAlign.left,
        )),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////
class CustomeButtonWithIcon extends StatelessWidget {
  const CustomeButtonWithIcon(
      {super.key, this.onTap, required this.text, this.color});
  final VoidCallback? onTap;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(17),
            border: Border.all(
              width: 2,
              color: kMainColor,
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 35,
              height: 35,
              child: Image.asset('images/googleIcon.jpg'),
            ),
            const Horizintalspace(2),
            Text(
              text,
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: kMainColor1),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////////
class CustomGeneralButton1 extends StatelessWidget {
  const CustomGeneralButton1(
      {super.key,
      required this.text,
      required this.onTap,
      required Color color});
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigator;
      },
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            color: kMainColor, borderRadius: BorderRadius.circular(8)),
        child: const Center(
            child: Text(
          'Explore ',
          style: TextStyle(
              fontSize: 14, color: kMainColor1, fontWeight: FontWeight.w500),
          textAlign: TextAlign.left,
        )),
      ),
    );
  }
}
///////////////////////////////////////////////////////////////////////////////

