
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'components/bottom_nav_bar.dart';
import 'screens/onboarding/onboarding_scrreen.dart';



class WidgetTree extends StatelessWidget {
//  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
//  UserModel _userInstance = UserModel().getInstance();

  Future<void> _reload({User user}) async {
    await user.reload();
//    await _firebaseFirestore
//        .collection("Users")
//        .doc(user.uid)
//        .get()
//        .then((value) => {
//      _userInstance.fromMap(value.data())
//    });
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return FutureBuilder(
      future: _reload(user: user),
      builder: (context, snapshot) {
        if (user == null) {
          return OnboardingScreen();
        }
        return  BottomNavBar();
      },
    );
  }
}
//
//class FirebaseFirestore {
//}
