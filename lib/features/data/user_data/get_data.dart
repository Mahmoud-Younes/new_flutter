
// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String userName = " ";
String firstname = " ";
String lastname = " ";
String email = " ";
getUserData() async {
  CollectionReference backinfo = FirebaseFirestore.instance.collection('usersAccounts');
  await backinfo.doc(FirebaseAuth.instance.currentUser?.uid)
      .get()
      .then((DocumentSnapshot docs) {
    final data = docs.data() as Map<dynamic, dynamic>;
    //print("///////////////////////////////////////////////////////////////");
    print(data);
    //print("///////////////////////////////////////////////////////////////");
 firstname = data["fisrtName"];
    lastname = data["lastName"];
    userName = data["userName"];
    email = data["email"];
  });
}



