import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_app/models/user_model.dart';
import 'package:driver_app/ui/screens/home/home_screen.dart';
import 'package:driver_app/ui/screens/signup/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  static const String TAG = "/signinScreen";
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  UserModel _userInstance = UserModel().getInstance();

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  void initState() {
    /*FirebaseAuth.instance.authStateChanges()
        .listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        getUser();
        //Navigator.pushNamed(context, HomeScreen.TAG);
      }
    });*/
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
            child: Text("SIGN IN"),
            onPressed: _signin,
          ),
        ),

        Container(height: 10.0),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Don't have an account? "),
            GestureDetector(
              onTap: () => {
                Navigator.pushNamed(context, SignUpScreen.TAG)
              },
              child: Text(
                "Sign Up",
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

  _signin() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text
    );
    getUser();
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
