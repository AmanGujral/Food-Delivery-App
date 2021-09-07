import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_app/models/user_model.dart';
import 'package:driver_app/ui/screens/home/home_screen.dart';
import 'package:driver_app/ui/screens/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WidgetTree extends StatelessWidget {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  UserModel _userInstance = UserModel().getInstance();

  Future<void> _reload({User user}) async {
    await user.reload();
    await _firebaseFirestore
        .collection("Drivers")
        .doc(user.uid)
        .get()
        .then((value) => {
      _userInstance.fromMap(value.data())
    });
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return FutureBuilder(
      future: _reload(user: user),
      // future: reauthenticateWithCredential(email: user.email, password: user.),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }
        if (user == null) {
          return SignUpScreen();
        }
        print("UID: ${user.uid}");
        /*_firebaseFirestore
            .collection("Users")
            .doc(user.uid)
            .get()
            .then((value) => {
          _userInstance.fromMap(value.data())
        });*/
        return  HomeScreen();
      },
    );
  }
}