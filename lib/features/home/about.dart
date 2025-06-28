import 'package:flutter/material.dart';
import 'package:new_flutter/core/extensions/context_extension.dart';
import 'package:new_flutter/core/routes/app_routes.dart';
import 'package:new_flutter/core/style/app_images.dart';
import 'package:new_flutter/core/style/colors.dart';
import 'package:new_flutter/features/Componants/buttons.dart';

class Aboutus extends StatelessWidget {
  const Aboutus({super.key});
  final int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(height: 50),
            ListTile(
              title: const Text('Home'),
              selected: _selectedIndex == 0,
              onTap: () {
                context.pushNamedAndRemoveUntil(AppRoutes.startApp);
              },
            ),
            ListTile(
              title: const Text('ProfilePage'),
              selected: _selectedIndex == 1,
              onTap: () {
                context.pushName(AppRoutes.profile);
              },
            ),
            ListTile(
              title: const Text('Chat Bot'),
              selected: _selectedIndex == 2,
              onTap: () {
                context.pushNamedAndRemoveUntil(AppRoutes.photoAnalysis);
              },
            ),
            ListTile(
              title: const Text('Log out'),
              selected: _selectedIndex == 2,
              onTap: () {
                context.pushNamedAndRemoveUntil(AppRoutes.login);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.explore, color: AppColors.amber),
            Text("Egypt.io", style: TextStyle(color: AppColors.black)),
          ],
        ),
        iconTheme: const IconThemeData(),
        backgroundColor: Colors.grey[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            Image.asset(
              AppImages.images9,
              fit: BoxFit.cover,
              width: 300,
              height: 150,
            ),
            const Text(
              "About Us",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // ignore: avoid_unnecessary_containers
            Container(
              child: const Text(
                '''The application helps you explore new places and enjoy various experiences with your friends or family.
                The application displays illustrative pictures of the place you are going to so that you have a background on what the place looks like and all the special details.
                
                It gives you a unique experience as it provides you with the service of seeing tourist places and knowing their prices before going''',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),

            Container(
              padding: const EdgeInsets.all(20),
              child: ActionButton(
                width: 60,
                color: AppColors.black,
                text: "Explore",
                onTap: () {
                  context.pushNamedAndRemoveUntil(AppRoutes.startApp);
                },
                isBold: true,
                isGradient: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
