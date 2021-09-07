import 'package:flutter/material.dart';
import 'package:restaurant_app/models/user_model.dart';
import 'package:restaurant_app/ui/screens/home/home_screen.dart';
import 'package:restaurant_app/ui/screens/signin/components/background.dart';
import 'package:restaurant_app/ui/screens/signup/signup_screen.dart';
import 'package:restaurant_app/ui/widgets/already_have_an_account_acheck.dart';
import 'package:restaurant_app/ui/widgets/rounded_button.dart';
import 'package:restaurant_app/ui/widgets/rounded_input_field.dart';
import 'package:restaurant_app/ui/widgets/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignInScreen extends StatefulWidget {
  static const String TAG = "/signinScreen";
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  FirebaseFirestore db;
  FirebaseAuth auth;
  UserModel _userInstance;

  String _email;
  String _password;
  @override
  Widget build(BuildContext context) {
    auth  = FirebaseAuth.instance;
    db = FirebaseFirestore.instance;
    _userInstance = UserModel().getInstance();

    /*auth
        .authStateChanges()
        .listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        getUser();
      }
    });*/

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "lib/assets/icons/login.svg",
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                hintText: "Your Email",
                onChanged: (value) {
                  _email = value;
                },
              ),
              RoundedPasswordField(
                onChanged: (value) {
                  _password = value;
                },
              ),
              RoundedButton(
                text: "LOGIN",
                press: () async {
                  await auth.signInWithEmailAndPassword(
                      email: _email,
                      password: _password);
                  getUser();

                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.pushNamed(context, SignUpScreen.TAG);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  getUser() async {
    await db.collection("Restaurants")
        .doc(auth.currentUser.uid)
        .get()
        .then((value) => {
      _userInstance.fromMap(value.data()),
      Navigator.pushNamed(context, HomeScreen.TAG)});
  }
}
