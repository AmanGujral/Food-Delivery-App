import 'package:driver_app/models/user_model.dart';
import 'package:driver_app/ui/screens/home/components/app_bar.dart';
import 'package:driver_app/ui/screens/home/components/go_button.dart';
import 'package:driver_app/ui/screens/home/components/map_view.dart';
import 'package:driver_app/ui/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  static const String TAG = "/homeScreen";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel _userInstance = UserModel().getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Appbar(),
      body: MapView(),
      drawer: AppDrawer(),
      floatingActionButton: GoButton(callback: () => {
        setState(() {})
      },),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
