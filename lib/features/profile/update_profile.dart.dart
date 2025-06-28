
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter/core/widgets/contants.dart';
import 'package:new_flutter/features/Auth/presentation/pages/login/widgets/login.dart';
import 'package:new_flutter/features/Componants/buttons.dart';



class UpdateinfoPage extends StatefulWidget {
  const UpdateinfoPage({super.key});

  @override
  State<UpdateinfoPage> createState() => _UpdateinfoPageState();
}

TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController mobileController =
    TextEditingController();
bool autofocus = false;

class _UpdateinfoPageState extends State<UpdateinfoPage> {
  updateProfileData() async {
    //To Get Current User
    User user = FirebaseAuth.instance.currentUser!;
    CollectionReference profile =
        FirebaseFirestore.instance.collection('usersAccounts');
    profile.doc(user.uid).update(
      {
        'userName': nameController.text,
        'email': emailController.text,
        'mobileNumber': mobileController.text,
      },
    ).then((request) {
      Login.showSnackBar(
        context,
        "Profile data updated successfully",
        color: Colors.green,
      );
    }).catchError((e) {
      Login.showSnackBar(
        context,
        "Please try again. $e.",
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.grey[50],
                  width: double.infinity,
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const BackBtn(),
                      const Text(
                        "Profile",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 80),
                      autofocus
                          ? const SizedBox(width: 90, height: 60)
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                  autofocus = true;
                                });
                              },
                              child: const SizedBox(
                                height: 60,
                                width: 90,
                                child: Center(
                                  child: Text(
                                    'Update',
                                    style: TextStyle(
                                      color: kMainColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                Divider(height: 10, color: Colors.black.withOpacity(0.35)),
                const SizedBox(height: 15),
                const Center(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 75,
                      color: kMainColor,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  "GENERAL INFORMATION",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.50),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        "User Name",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.35),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: TextField(
                        autofocus: autofocus,
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 10,
                  color: Colors.black.withOpacity(0.35),
                ),
                const SizedBox(height: 40),
                Text(
                  "MANAGE ACCOUNT",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.50),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        "Email",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.35),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 10,
                  color: Colors.black.withOpacity(0.35),
                ),
                const SizedBox(height: 40),
                Text(
                  "CONTACTS",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.50),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        "Mobile",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.35),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: TextField(
                        controller: mobileController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 10,
                  color: Colors.black.withOpacity(0.35),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Visibility(
                      visible: autofocus,
                      child: SizedBox(
                        width: 100,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            updateProfileData();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kMainColor,
                              shadowColor: Colors.transparent),
                          child: const Text(
                            "OK",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
