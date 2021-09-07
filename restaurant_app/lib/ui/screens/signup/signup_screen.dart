import 'package:flutter/material.dart';
import 'package:restaurant_app/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:restaurant_app/models/user_model.dart';
import 'package:restaurant_app/ui/screens/home/home_screen.dart';
import 'package:restaurant_app/ui/screens/on_boarding/on_boarding_screen.dart';
import 'package:restaurant_app/ui/screens/signin/signin_screen.dart';
import 'file:///D:/Mapp%20Inc/uber_eats/restaurant_app/lib/ui/widgets/background.dart';
import 'package:restaurant_app/ui/screens/signup/components/or_divider.dart';
import 'file:///D:/Mapp%20Inc/uber_eats/restaurant_app/lib/ui/widgets/rounded_button.dart';
import 'file:///D:/Mapp%20Inc/uber_eats/restaurant_app/lib/ui/widgets/rounded_input_field.dart';
import 'file:///D:/Mapp%20Inc/uber_eats/restaurant_app/lib/ui/widgets/rounded_password_field.dart';
import 'package:restaurant_app/ui/screens/signup/components/social_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant_app/ui/widgets/already_have_an_account_acheck.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpScreen extends StatefulWidget {
  static const String TAG = "/signupScreen";
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  String _email;
  String _password;

  FirebaseAuth auth;
  FirebaseFirestore db;
  UserModel _userInstance = UserModel().getInstance();

  @override
  void initState() {
    auth  = FirebaseAuth.instance;
    db = FirebaseFirestore.instance;

    auth.authStateChanges()
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
    /*auth  = FirebaseAuth.instance;
    db = FirebaseFirestore.instance;
    _userInstance = UserModel().getInstance();*/

    /*auth.authStateChanges()
        .listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        getUser();
        //Navigator.pushNamed(context, HomeScreen.TAG);
      }
    });*/

    return Scaffold(
      body: body(),
    );
  }

  Widget body() {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "lib/assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
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
              text: "SIGNUP",
              press: () async {
                try {
                  UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: _email,
                      password: _password
                  );
                  addUser(userCredential);
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                  }
                } catch (e) {
                  print(e);
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.pushNamed(context, SignInScreen.TAG);
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "lib/assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "lib/assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "lib/assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  addUser(UserCredential userCredential) async {
    _userInstance.id = userCredential.user.uid;
    _userInstance.email = _email;
    _userInstance.name = "Aman";

    await db.collection("Restaurants")
        .doc(userCredential.user.uid)
        .set(_userInstance.toMap());
  }

  getUser() async {
    await db.collection("Restaurants")
        .doc(auth.currentUser.uid)
        .get()
        .then((value) => {
      _userInstance.fromMap(value.data()),
      Navigator.pushNamed(context, OnBoardingScreen.TAG)});
  }
}
