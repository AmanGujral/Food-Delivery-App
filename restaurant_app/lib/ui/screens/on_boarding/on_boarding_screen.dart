import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/colors.dart';
import 'package:restaurant_app/models/user_model.dart';
import 'package:restaurant_app/ui/screens/home/home_screen.dart';
import 'package:restaurant_app/ui/widgets/rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String TAG = "/onBoardingScreen";
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  UserModel _userInstance = UserModel().getInstance();

  TextEditingController nameController;
  TextEditingController phoneController;
  TextEditingController addressController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
    );
  }

  Widget body() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            //margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
            elevation: 8.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width)),
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.25,
              backgroundImage: AssetImage("lib/assets/images/default_img.jpg"),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 50.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: CustomColors().primaryLightBg
            ),
            child: TextField(
              controller: nameController,
              cursorColor: CustomColors().primary,
              style: TextStyle(
                fontSize: 24.0,
              ),
              decoration: InputDecoration(
                hintText: "Restaurant Name",
                prefixIcon: Icon(Icons.subtitles_rounded, color: CustomColors().primary,),
                border: InputBorder.none,
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 30.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: CustomColors().primaryLightBg
            ),
            child: TextField(
              controller: phoneController,
              cursorColor: CustomColors().primary,
              style: TextStyle(
                fontSize: 24.0,
              ),
              decoration: InputDecoration(
                hintText: "Phone Number",
                prefixIcon: Icon(Icons.phone, color: CustomColors().primary,),
                border: InputBorder.none,
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 30.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: CustomColors().primaryLightBg
            ),
            child: TextField(
              controller: addressController,
              cursorColor: CustomColors().primary,
              style: TextStyle(
                fontSize: 24.0,
              ),
              decoration: InputDecoration(
                hintText: "Restaurant Address",
                prefixIcon: Icon(Icons.location_on, color: CustomColors().primary,),
                border: InputBorder.none,
              ),
            ),
          ),

          RoundedButton(
            text: "CONTINUE",
            press: _continue(),
          ),
        ],
      ),
    );
  }

  _continue() async {
    if(nameController.text.isNotEmpty && phoneController.text.isNotEmpty && addressController.text.isNotEmpty){
      _userInstance.name = nameController.text;
      _userInstance.phone = phoneController.text;
      _userInstance.address = addressController.text;

      await FirebaseFirestore.instance
          .collection("Restaurants")
          .doc(_userInstance.id)
          .update(_userInstance.toMap());

      Navigator.pushNamed(context, HomeScreen.TAG);

    }
  }
}
