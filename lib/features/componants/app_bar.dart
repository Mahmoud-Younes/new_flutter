
import 'package:flutter/material.dart';
import 'package:new_flutter/features/Componants/buttons.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget {

  final String title;
  bool isBoldTitle;

  FontWeight bold = FontWeight.bold;
  FontWeight normal = FontWeight.normal;

  final bool visibleDescription;
  final String descriptionTitle;
  double desTitleSize;

  bool visibleSteps;
  int stepNum;

  bool backButton;

  CustomAppBar({
    Key? key,
    required this.title,
    this.isBoldTitle = true,
    required this.visibleDescription,
    required this.descriptionTitle,
    this.desTitleSize = 20,
    this.visibleSteps = false,
    this.stepNum = 1,
    this.backButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 17),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              backButton
                  ? const BackBtn()
                  : Container(color: Colors.grey[50], width: 47, height: 47),
              Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 20, fontWeight: isBoldTitle ? bold : normal),
                  ),
                  Visibility(
                    visible: visibleSteps,
                    child: const SizedBox(height: 5),
                  ),
                  Visibility(
                    visible: visibleSteps,
                    child: Text(
                      "Step $stepNum/2",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.55),
                          fontWeight: isBoldTitle ? bold : normal),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 47, height: 47)
            ],
          ),
          const SizedBox(height: 17),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Visibility(
              visible: visibleDescription,
              child: Text(
                descriptionTitle,
                style: TextStyle(fontSize: desTitleSize),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              child: GestureDetector(
                onTap: () {
                 
                },
                child: const CircleAvatar(
                    radius: 28,
                    backgroundColor: Color(0xffDE0A1E),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    )),
              ),
            ),
            SizedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    splashRadius: 27,
                    splashColor: const Color(0xffFFB3BF),
                    icon: const Icon(Icons.calendar_month),
                    iconSize: 27,
                    onPressed: () {
                     
                    },
                  ),
                  IconButton(
                    splashRadius: 27,
                    splashColor: const Color(0xffFFB3BF),
                    icon: const Icon(Icons.notifications),
                    iconSize: 27,
                    onPressed: () {
                     
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
