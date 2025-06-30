import 'package:flutter/material.dart';
import 'package:new_flutter/core/style/colors.dart';
import 'package:new_flutter/features/ai__train_model/screens/home_screen.dart';
import 'package:new_flutter/features/screens/home.dart';
import 'package:new_flutter/features/Profile/profile_page.dart';

class IconButtomBar extends StatelessWidget {
  const IconButtomBar({
    super.key,
    required this.text,
    required this.icon,
    required this.selected,
    required this.onPressed,
    required this.selectedIcon,
  });

  final String text;
  final IconData icon, selectedIcon;
  final bool selected;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPressed,
          icon:
              selected
                  ? Icon(selectedIcon, color: AppColors.amber, size: 24)
                  : Icon(icon, size: 30),
        ),
        Text(
          textAlign: TextAlign.center,
          text,
          style: TextStyle(
            fontSize: 11,
            height: 0.22,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            color: selected ? AppColors.amber : AppColors.black,
          ),
        ),
      ],
    );
  }
}

class StartApp extends StatefulWidget {
  const StartApp({super.key});

  static int selectedPage = 0;

  @override
  State<StartApp> createState() => _StartAppState();
}

class _StartAppState extends State<StartApp> {
  List<Widget> pages = [
    const CategoriesScreen(),
    const HomeScreen(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[StartApp.selectedPage],
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 75,
        child: BottomAppBar(
          elevation: 0,
          color: Colors.transparent,
          child: SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButtomBar(
                  text: "Analysis",
                  icon: Icons.image_search_outlined,
                  selectedIcon: Icons.chat,
                  selected: StartApp.selectedPage == 1,
                  onPressed: () {
                    setState(() {
                      StartApp.selectedPage = 1;
                    });
                  },
                ),
                IconButtomBar(
                  text: "Home",
                  icon: Icons.home,
                  selectedIcon: Icons.home,
                  selected: StartApp.selectedPage == 0,
                  onPressed: () {
                    setState(() {
                      StartApp.selectedPage = 0;
                    });
                  },
                ),
                IconButtomBar(
                  text: "Profile",
                  icon: Icons.person,
                  selectedIcon: Icons.person,
                  selected: StartApp.selectedPage == 2,
                  onPressed: () {
                    setState(() {
                      StartApp.selectedPage = 2;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
