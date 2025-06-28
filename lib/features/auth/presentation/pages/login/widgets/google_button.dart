// ignore_for_file: use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:new_flutter/core/style/app_images.dart';
import 'package:new_flutter/features/Screens/Home.dart';
import 'package:new_flutter/core/widgets/contants.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    //Google signIn
    Future<UserCredential> signInWithGoogle() async {
      //For CircularProgressIndicator
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(color: kMainColor),
          );
        },
      );

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      //pop the CircularProgressIndicator
      Navigator.pop(context);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const CategoriesScreen(),
        ),
        (Route<dynamic> route) => false,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }

    return SizedBox(
      height: 40,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Colors.white,
        ),
        onPressed: () async {
          await signInWithGoogle();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 35,
              height: 30,
              child: Image.asset(AppImages.googleIcon),
            ),
            const Text(
              'Login with Google',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}
