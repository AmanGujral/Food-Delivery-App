import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_app/models/user_model.dart';
import 'package:driver_app/ui/screens/home/home_screen.dart';
import 'package:driver_app/ui/screens/signin/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  static const String TAG = "/signupScreen";
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  UserModel _userInstance = UserModel().getInstance();

  TextEditingController lastNameController = new TextEditingController();
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges()
        .listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        getUser();
        //Navigator.pushNamed(context, HomeScreen.TAG);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
    );
  }

  Widget body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.07),
          decoration: BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: TextField(
            controller: firstNameController,
            cursorColor: Colors.black,
            style: TextStyle(
                fontSize: 20.0
            ),
            decoration: InputDecoration(
              hintText: "First Name",
              border: InputBorder.none,
              prefixIcon: Icon(Icons.person, color: Colors.black,),
            ),
          ),
        ),

        Container(height: 25),

        Container(
          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.07),
          decoration: BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: TextField(
            controller: lastNameController,
            cursorColor: Colors.black,
            style: TextStyle(
                fontSize: 20.0
            ),
            decoration: InputDecoration(
              hintText: "Last Name",
              border: InputBorder.none,
              prefixIcon: Icon(Icons.person, color: Colors.black,),
            ),
          ),
        ),

        Container(height: 25),

        Container(
          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.07),
          decoration: BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: TextField(
            controller: emailController,
            cursorColor: Colors.black,
            style: TextStyle(
              fontSize: 20.0
            ),
            decoration: InputDecoration(
              hintText: "Email",
              border: InputBorder.none,
              prefixIcon: Icon(Icons.email, color: Colors.black,),
            ),
          ),
        ),

        Container(height: 25),

        Container(
          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.07),
          decoration: BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: TextField(
            controller: passwordController,
            cursorColor: Colors.black,
            style: TextStyle(
                fontSize: 20.0
            ),
            decoration: InputDecoration(
              hintText: "Password",
              border: InputBorder.none,
              prefixIcon: Icon(Icons.lock, color: Colors.black,),
            ),
          ),
        ),

        Container(height: 30),

        Container(
          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.07),
          decoration: BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: MaterialButton(
            child: Text("SIGN UP"),
            onPressed: _signup,
          ),
        ),

        Container(height: 10.0),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Already have an account? "),
            GestureDetector(
              onTap: () => {
                Navigator.pushNamed(context, SignInScreen.TAG)
              },
              child: Text(
                "Sign In",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _signup() async {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text
    );
    addUser(userCredential);
  }

  addUser(UserCredential userCredential) async {
    _userInstance.id = userCredential.user.uid;
    _userInstance.email = emailController.text;
    _userInstance.firstName = firstNameController.text;
    _userInstance.lastName = lastNameController.text;
    _userInstance.currentStatus = UserModel.DRIVER_STATUS_OFFLINE;

    await FirebaseFirestore.instance
        .collection("Drivers")
        .doc(userCredential.user.uid)
        .set(_userInstance.toMap());
  }

  getUser() async {
    await FirebaseFirestore.instance.collection("Drivers")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) => {
      _userInstance.fromMap(value.data()),
      Navigator.pushNamed(context, HomeScreen.TAG)});
  }
}
