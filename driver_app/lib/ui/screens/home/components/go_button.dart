import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_app/models/user_model.dart';
import 'package:driver_app/ui/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class GoButton extends StatefulWidget {
  final Function callback;

  GoButton({@required this.callback});
  @override
  _GoButtonState createState() => _GoButtonState();
}

class _GoButtonState extends State<GoButton> {
  UserModel _userInstance = UserModel().getInstance();

  @override
  Widget build(BuildContext context) {
    if(_userInstance.currentStatus == UserModel.DRIVER_STATUS_OFFLINE) {
      return Container(
        height: MediaQuery
            .of(context)
            .size
            .width * 0.3,
        width: MediaQuery
            .of(context)
            .size
            .width * 0.2,
        child: FloatingActionButton(
          elevation: 4.0,
          backgroundColor: Colors.green,
          child: Text(
            'GO',
            style: TextStyle(
              fontSize: 24.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: _goActive,
        ),
      );
    }
    else {
      return Container(height: 0,);
    }
  }

  _goActive() async {
    _userInstance.currentStatus = UserModel.DRIVER_STATUS_ONLINE;

    await FirebaseFirestore.instance.collection("Drivers")
        .doc(_userInstance.id)
        .update(_userInstance.toMap());

    widget.callback();
    /*setState(() {
      Navigator.pushNamed(context, HomeScreen.TAG);
    });*/
  }
}
