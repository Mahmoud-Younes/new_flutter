import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter/core/widgets/contants.dart';
import 'package:new_flutter/features/Auth/presentation/pages/login/widgets/login.dart';
import 'package:new_flutter/features/Home/about.dart';
import 'package:new_flutter/features/Profile/profile_page.dart';
import 'package:new_flutter/start_app/start_page.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
   String userName = '';
    String email = '';
   getUserData() async {
    CollectionReference backinfo =
        FirebaseFirestore.instance.collection('usersAccounts');
    await backinfo
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((DocumentSnapshot docs) {
      final data = docs.data() as Map<dynamic, dynamic>;
      //print("///////////////////////////////////////////////////////////////");
      print(data);

      userName = data["userName"];
      email = data["email"];
      setState(() {});
    });
  }
  @override
  initState() {
    super.initState();
    getUserData();
  }
  @override
  Widget build(BuildContext context) {
   
    return Drawer(
      width: 270,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [kMainColor, kMainColor1],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 38,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 48, color: kMainColor),
                ),
                const SizedBox(height: 12),
                Text(
                  userName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _drawerItem(
                  icon: Icons.home,
                  text: 'Home',
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const StartApp()),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
                _drawerItem(
                  icon: Icons.person,
                  text: 'Profile',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ));
                  },
                ),
                _drawerItem(
                  icon: Icons.info_outline,
                  text: 'About us',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Aboutus()),
                    );
                  },
                ),
                const Divider(height: 32, thickness: 1, indent: 16, endIndent: 16),
                _drawerItem(
                  icon: Icons.logout,
                  text: 'Log out',
                  color: Colors.red,
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const Login()),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(icon, color: color ?? kMainColor),
      title: Text(
        text,
        style: TextStyle(
          color: color ?? Colors.black87,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      onTap: onTap,
      horizontalTitleGap: 0,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      hoverColor: kMainColor.withOpacity(0.08),
    );
  }
}