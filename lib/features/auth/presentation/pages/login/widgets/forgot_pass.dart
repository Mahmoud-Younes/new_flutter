// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter/core/style/app_images.dart';
import 'package:new_flutter/core/widgets/contants.dart';
import 'package:new_flutter/features/Auth/presentation/pages/login/widgets/login.dart';
import 'package:new_flutter/features/Componants/buttons.dart';
import 'package:new_flutter/features/Componants/my_text_form_field.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  String? emailValue;

  Future passwordReset() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            color: kMainColor,
          ),
        );
      },
    );
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text);
      if (mounted) {
        Login.showSnackBar(
          context,
          "The password reset link sent! Check your email",
          color: const Color(0xff388e3c),
        );
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      String? errorType;
      switch (e.message) {
        case 'ERROR_INVALID_EMAIL':
          errorType = "Your email address appears to be malformed.";
          break;
        case 'The email address is badly formatted.':
          errorType = "The account you want to Registration with is not valid.";
          break;
        case 'ERROR_EMAIL_ALREADY_IN_USE':
        case 'The email address is already in use by another account.':
          errorType =
              "The email has already been used. Please enter your own email.";
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
          errorType = "Please enter your Email";
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 15),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BackBtn(),
                  ],
                ),
                SizedBox(
                    width: double.infinity,
                    height: 350,
                    child: Image.asset(
                     AppImages.forgetPassword,
                      fit: BoxFit.cover,
                    )),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: RichText(
                    text: const TextSpan(
                      text: "Forgot\nPassword",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      children: [
                        TextSpan(
                          text: "?",
                          style: TextStyle(
                            color: kMainColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Don't worry! It happens. Please enter the\naddress associated with your account.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black.withOpacity(0.75),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Form(
                  key: formstate,
                  child: MyFormField(
                    controller: _emailController,
                    hintText: "Email",
                    setIcon: true,
                    icon: const Icon(
                      Icons.alternate_email,
                      color: kMainColor,
                    ),
                    value: emailValue,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    validator: (emailValue) {
                      if (emailValue!.isEmpty) {
                        return "Email cannot be empty.";
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(emailValue)) {
                        return "Please enter a valid email address.";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(height: 30),
                ActionButton(
                  color: Colors.black,
                  text: "Submit",
                  onTap: () {
                    if (formstate.currentState!.validate()) {
                      formstate.currentState!.save();
                      passwordReset();
                    }
                  },
                  isBold: true,
                  isGradient: false,
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
