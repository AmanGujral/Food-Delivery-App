import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_app/models/user_model.dart';
import 'package:driver_app/ui/screens/dummy_navigation.dart';
import 'package:driver_app/ui/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  UserModel _userInstance = UserModel().getInstance();
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          canvasColor: Colors.black
      ),
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _drawerHeader(),
            Container(height: 20.0,),
            _drawerItem(title: 'Inbox', icon: Icons.feedback_rounded, onTap: () => _itemClicked()),
            _drawerItem(title: 'Promotions', icon: Icons.payment_rounded, onTap: () => {Navigator.pushNamed(context, DummyNavigation.TAG)}),
            _drawerItem(title: 'Earnings', icon: Icons.restaurant_menu_rounded, onTap: () => {Navigator.pushNamed(context, DummyNavigation.TAG)}),
            _drawerItem(title: 'Wallet', icon: Icons.file_copy_rounded, onTap: () => {Navigator.pushNamed(context, DummyNavigation.TAG)}),
            _drawerItem(title: 'Account', icon: Icons.settings_rounded, onTap: () => {Navigator.pushNamed(context, DummyNavigation.TAG)}),
            Container(height: 20.0,),
            Divider(height: 1.0, thickness: 1.0, indent: 20.0, color: Colors.white30,),
            Container(height: 20.0,),
            _drawerStatusWidget(_userInstance.currentStatus),
            Container(height: 20.0,),
            _goOfflineButton(),

          ],
        ),
      ),
    );
  }

  Widget _drawerHeader() {
    /*return DrawerHeader(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'lib/assets/images/default_img.jpg',
            fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.bottomLeft,
            child: Text(
              'Food Factory',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
              ),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black87],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
              ),
            ),
          ),
        ],
      ),
    );*/

    return UserAccountsDrawerHeader(
      accountName: Text(
        _userInstance.firstName,
        style: TextStyle(
            fontSize: 20.0
        ),
      ),
      accountEmail: null,
      currentAccountPicture: CircleAvatar(
        backgroundImage: AssetImage('lib/assets/images/default_img.jpg'),
      ),
      decoration: BoxDecoration(
        /*gradient: LinearGradient(
              colors: [CustomColors().primary, CustomColors().primaryLight],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
          )*/
      ),
    );
  }

  Widget _drawerItem({IconData icon, String title, GestureTapCallback onTap}) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
            fontSize: 22.0,
            color: Colors.white
        ),
      ),
      //leading: Icon(icon),
      onTap: onTap,
    );
  }

  Widget _drawerStatusWidget(String status) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        status,
        style: TextStyle(
          color: status == UserModel.DRIVER_STATUS_ONLINE
              ? Colors.green
              : Colors.red,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _goOfflineButton() {
    if(_userInstance.currentStatus == UserModel.DRIVER_STATUS_ONLINE) {
      return MaterialButton(
        height: 50,
        child: Text(
          "Go Offline",
          style: TextStyle(fontSize: 20.0),),
        color: Colors.red,
        onPressed: _goOffline,
      );
    }
    else {
      return Container(height: 0,);
    }
  }

  _goOffline() async {
    _userInstance.currentStatus = UserModel.DRIVER_STATUS_OFFLINE;

    await FirebaseFirestore.instance.collection("Drivers")
        .doc(_userInstance.id)
        .update(_userInstance.toMap());

    setState(() {
      Navigator.pushNamed(context, HomeScreen.TAG);
    });
  }

  _itemClicked() {
    Navigator.pop(context);
    Navigator.pushNamed(context, DummyNavigation.TAG);
  }
}
