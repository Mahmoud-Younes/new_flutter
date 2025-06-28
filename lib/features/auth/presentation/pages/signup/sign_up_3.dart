import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter/core/widgets/contants.dart';
import 'package:new_flutter/features/Auth/presentation/pages/login/widgets/login.dart';
import 'package:new_flutter/features/Componants/app_bar.dart';
import 'package:new_flutter/features/Componants/buttons.dart';
import 'package:new_flutter/features/Componants/date_picker.dart';
import 'package:new_flutter/start_app/start_page.dart';

import '../../../../Componants/drop_down.dart';

// ignore: must_be_immutable
class SignUp3 extends StatefulWidget {
  SignUp3({
    super.key,
    required this.userName,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.number,
  });

  String userName, email, password, firstName, lastName;
  int number;

  @override
  State<SignUp3> createState() => _SignUp3State();
}

class _SignUp3State extends State<SignUp3> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  //Sign In Method With Email And Password
  signUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(color: kMainColor),
        );
      },
    );
    try {
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: widget.email,
            password: widget.password,
          );
      User? user = result.user;
      //add user details
      Future addUserDetails() async {
        FirebaseFirestore.instance
            .collection('usersAccounts')
            .doc(user?.uid)
            .set({
              'userName': widget.userName,
              'email': widget.email,
              'fisrtName': widget.firstName,
              'lastName': widget.lastName,
              'mobileNumber': widget.number,
              'gender': GenderDropDown.selectedValue,
              'birthdayDate': CustomDataPicker.date,
              'location': LocationDropDown.selectedValue,
            })
            .then(
              (value) =>
                  Login.showSnackBar(context, "Welcome", color: Colors.green),
            )
            .catchError((e) {
              (value) => Login.showSnackBar(
                context,
                "Something went wrong, Please try again.",
              );
            });
      }

      addUserDetails();
      //pop CircularProgressIndicator
      if (mounted) {
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const StartApp(),
          ),
          (Route<dynamic> route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      String? errorType;
      switch (e.message) {
        case 'ERROR_INVALID_EMAIL':
          errorType = "Your email address appears to be malformed.";
          break;
        case 'The email address is already in use by another account.':
          errorType =
              "The email has already been registered. Please login or reset your password.";
          break;
        case 'The email address is badly formatted.':
          errorType = "The account you want to Registration with is not valid.";
          break;
        case 'ERROR_EMAIL_ALREADY_IN_USE':
          errorType =
              "The email has already been registered. Please login or reset your password.";
          break;
        case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
          errorType = "No internet connection";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
        case "operation-not-allowed":
          errorType = "Server error, please try again later.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorType = "Too many requests to log into this account.";
          break;
        case 'Given String is empty or null':
          errorType = "Please fill \"Email\" and \"Password\" fields ";
          break;
        // ...
        default:
          errorType = "${e.message}. Please try again.";
      }
      Login.showSnackBar(context, errorType);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                CustomAppBar(
                  title: "User Information",
                  visibleDescription: true,
                  descriptionTitle: "Fill in your information\nto get started",
                  visibleSteps: true,
                  stepNum: 2,
                ),
                const SizedBox(height: 20),

                Form(
                  key: formstate,
                  child: Column(
                    children: [
                      GenderDropDown(
                        labelText: 'Gender',
                        hint: "Male",
                        items: const ['Male', 'Female'],
                      ),
                      const SizedBox(height: 15),
                      const CustomDataPicker(),
                      const SizedBox(height: 15),
                      LocationDropDown(
                        labelText: 'Location',
                        hint: "Address, Street ,City",
                        items: const [
                          'Cairo',
                          'Alexandria',
                          'Gizeh',
                          'Beni Suef',
                          'Assuit',
                          'Qena',
                          'Sohag',
                          'Hurghada',
                          'Luxor',
                          'Aswan',
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                ActionButton(
                  width: 150,
                  color: Colors.black,
                  text: "Register",
                  isBold: true,
                  onTap: () {
                    if (formstate.currentState!.validate()) {
                      signUp();
                    }
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
