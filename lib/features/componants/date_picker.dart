import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_flutter/core/widgets/contants.dart';

class CustomDataPicker extends StatefulWidget {
  const CustomDataPicker({Key? key}) : super(key: key);

  static DateTime selectedDate = DateTime(1999);

  static var date = DateFormat.yMd().format(CustomDataPicker.selectedDate);
  @override
  State<CustomDataPicker> createState() => _CustomDataPickerState();
}

class _CustomDataPickerState extends State<CustomDataPicker> {
  void _datePicker(BuildContext context) {
    showDatePicker(
      context: context,
      firstDate: DateTime(1963),
      lastDate: DateTime(2030),
      initialDate: DateTime(1998),
    ).then((val) {
      if (val == null) {
        return;
      }
      setState(() {
        CustomDataPicker.selectedDate = val;
      });
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: GestureDetector(
        onTap: () {
          _datePicker(context);
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              width: double.infinity,
              child: const Text(
                "Birthday Date",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xffF1F5F9),
                borderRadius: BorderRadius.circular(12),
              ),
              width: double.infinity,
              height: 60,
              child: Row(
                children: [
                  const SizedBox(width: 4),
                  const Icon(Icons.calendar_month, color: kMainColor, size: 25),
                  const SizedBox(width: 2),
                  Text(
                    DateFormat.yMMMEd().format(CustomDataPicker.selectedDate),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0F172A),
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_downward, color: kMainColor, size: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
