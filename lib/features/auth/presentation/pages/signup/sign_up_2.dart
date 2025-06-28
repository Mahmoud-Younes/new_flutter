import 'package:flutter/material.dart';
import 'package:new_flutter/features/Auth/presentation/pages/SignUp/sign_up_3.dart';
import 'package:new_flutter/features/Componants/app_bar.dart';
import 'package:new_flutter/features/Componants/buttons.dart';
import 'package:new_flutter/features/Componants/my_text_form_field.dart';

// ignore: must_be_immutable
class SignUp2 extends StatelessWidget {
  SignUp2({
    super.key,
    this.userName,
    this.email,
    this.password,
  });

  String? userName, email, password;

  final GlobalKey<FormState> _formField = GlobalKey<FormState>();

  final TextEditingController _firsNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  String? firstName;
  String? lastName;
  int? number;

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
                  title: "Complete the data",
                  visibleDescription: true,
                  descriptionTitle: "Fill in your information\nto get started",
                  visibleSteps: true,
                  stepNum: 1,
                ),
                const SizedBox(height: 5),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: const Text(
                      "This data will be displayed in your account\nprofile for security"),
                ),
                const SizedBox(height: 10),
                Form(
                    key: _formField,
                    child: Column(
                      children: [
                        MyFormField(
                          controller: _firsNameController,
                          hintText: "First Name",
                          value: firstName,
                          keyboardType: TextInputType.text,
                          validator: (firstName) {
                            if (firstName!.isEmpty ||
                                !RegExp(r'^[a-z A-Z]+$').hasMatch(firstName)) {
                              return "First name is required";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        MyFormField(
                          controller: _lastNameController,
                          hintText: "Last Name",
                          value: lastName,
                          keyboardType: TextInputType.text,
                          validator: (lastName) {
                            if (lastName!.isEmpty ||
                                !RegExp(r'^[a-z A-Z]+$').hasMatch(lastName)) {
                              return "Last name is required";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        MyFormField(
                          controller: _numberController,
                          hintText: "Mobile Number",
                          value: number.toString(),
                          validator: (number) {
                            if (number!.isEmpty ||
                                !RegExp(r'^([+]\d{2})?\d{11}$')
                                    .hasMatch(number)) {
                              return "Mobile number must be exact 11 digits";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                        ),
                      ],
                    )),
                const SizedBox(height: 50),
                ActionButton(
                  width: 100,
                  height: 40,
                  color: Colors.black,
                  text: "Next",
                  onTap: () {
                    if (_formField.currentState!.validate()) {
                      _formField.currentState!.save();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUp3(
                            userName: userName!,
                            email: email!,
                            password: password!,
                            firstName: _firsNameController.text,
                            lastName: _lastNameController.text,
                            number: int.parse(_numberController.text),
                          ),
                        ),
                      );
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
