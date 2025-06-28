// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:new_flutter/core/style/app_images.dart';
import 'package:new_flutter/core/widgets/contants.dart';
import 'package:new_flutter/features/Auth/presentation/pages/SignUp/sign_up_2.dart';
import 'package:new_flutter/features/Auth/presentation/pages/login/widgets/login.dart';
import 'package:new_flutter/features/Componants/buttons.dart';
import 'package:new_flutter/features/Componants/my_text_form_field.dart';
import 'package:new_flutter/features/Componants/underline_text.dart';


// ignore: must_be_immutable
class SignUp1 extends StatefulWidget {
  const SignUp1({super.key});

  @override
  State<SignUp1> createState() => _SignUp1State();
}

class _SignUp1State extends State<SignUp1> {
  final GlobalKey<FormState> _formField = GlobalKey<FormState>();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? username;
  String? email;
  String? pass;

  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            
            child: Column(
              children: [
                 const Row( 
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [ 
                    BackBtn(),
                  ],
                ),

                ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.asset(fit: BoxFit.cover, AppImages.signup,),
                ),
                const SizedBox(height: 10),
                //text under circle
                const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Form(
                  key: _formField,
                  child: Column(
                    children: [
                      //UserNameForm
                      MyFormField(
                        controller: _userNameController,
                        keyboardType: TextInputType.text,
                        hintText: 'User Name',
                        icon: const Icon(
                          Icons.person,
                          color: kMainColor,
                        ),
                        value: username,
                        setIcon: true,
                        validator: (username) {
                          if (username!.isEmpty ||
                              !RegExp(r'^[a-z A-Z]+$').hasMatch(username)) {
                            return "User name is required.";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 4),
                      //EmailForm
                      MyFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'Email',
                        icon: const Icon(
                          Icons.message,
                          color: kMainColor,
                        ),
                        value: email,
                        validator: (email) {
                          if (email!.isEmpty) {
                            return "Email cannot be empty.";
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(email)) {
                            return "Please enter a valid email address.";
                          } else {
                            return null;
                          }
                        },
                        setIcon: true,
                      ),
                      const SizedBox(height: 4),
                      //PasswordForm
                      MyFormField(
                        controller: _passwordController,
                        keyboardType: TextInputType.text,
                        obscureText: isVisible,
                        icon: const Icon(
                          Icons.password,
                          color: kMainColor,
                        ),
                        hintText: 'Password',
                        value: pass,
                        validator: (pass) {
                          if (pass!.isEmpty) {
                            return "Please enter your password";
                          } else {
                            return null;
                          }
                        },
                        textInputAction: TextInputAction.done,
                        setIcon: true,
                        suffix: GestureDetector(
                          onTap: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          child: isVisible
                              ? const Icon(Icons.visibility_off,color: kMainColor,)
                              : const Icon(Icons.visibility,color: kMainColor,),
                        ),
                      ),
                    ],
                  ),
                ),
                
                RichText(
                  text: TextSpan(
                    text: "By signing up, you'r agree to our ",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.30),
                      fontSize: 14,
                    ),
                    children: const [
                      TextSpan(
                        text: "Terms & Conditions\n",
                        style: TextStyle(
                          color: kMainColor1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "and ",
                      ),
                      TextSpan(
                        text: "Privacy Policy.",
                        style: TextStyle(
                          color: kMainColor1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 5),
                //NextButton
                ActionButton(
                  width: 130,
                  color: Colors.black,
                  text: 'Continue',
                  onTap: () {
                    if (_formField.currentState!.validate()) {
                      _formField.currentState!.save();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUp2(
                                  userName: _userNameController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                )),
                      );
                    }
                  },
                ),
                //Return to Login Screen
                const SizedBox(height: 5),
                UnderLineText(
                    text: 'Already have an account?',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
