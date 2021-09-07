import 'package:flutter/material.dart';
import 'package:restaurant_app/colors.dart';
import 'package:restaurant_app/ui/screens/dummy_navigation.dart';
import 'package:restaurant_app/ui/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant_app/ui/screens/menu/menu_screen.dart';
import 'package:restaurant_app/ui/screens/signin/signin_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _drawerHeader(),
          Container(height: 20.0,),
          _drawerItem(title: 'Home', icon: Icons.home_rounded, onTap: () => {Navigator.pushReplacementNamed(context, HomeScreen.TAG)}),
          _drawerItem(title: 'Feedback', icon: Icons.feedback_rounded, onTap: () => {Navigator.pushReplacementNamed(context, DummyNavigation.TAG)}),
          _drawerItem(title: 'Payments', icon: Icons.payment_rounded, onTap: () => {Navigator.pushReplacementNamed(context, DummyNavigation.TAG)}),
          _drawerItem(title: 'Menu', icon: Icons.restaurant_menu_rounded, onTap: () => {Navigator.pushReplacementNamed(context, MenuScreen.TAG)}),
          _drawerItem(title: 'Documents', icon: Icons.file_copy_rounded, onTap: () => {Navigator.pushReplacementNamed(context, DummyNavigation.TAG)}),
          _drawerItem(title: 'Settings', icon: Icons.settings_rounded, onTap: () => {Navigator.pushReplacementNamed(context, DummyNavigation.TAG)}),
          _drawerItem(title: 'Logout', icon: Icons.logout, onTap: () => {FirebaseAuth.instance.signOut().then((value) => {
            Navigator.pushNamed(context, SignInScreen.TAG)
          })}),
          Container(height: 20.0,),
          Divider(height: 1.0, thickness: 1.0, indent: 80.0, endIndent: 80.0, color: Colors.black26,),
          Container(height: 20.0,),
          _drawerStatusWidget('Online'),

        ],
      ),
    );
  }

  Widget _drawerHeader() {
    return DrawerHeader(
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
                fontSize: 22.0,
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
    );

    /*return UserAccountsDrawerHeader(
      accountName: Text('Food Factory'),
      accountEmail: Text('foodfactory@gmail.com'),
      currentAccountPicture: CircleAvatar(
        backgroundImage: AssetImage('lib/assets/images/default_img.jpg'),
      ),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [CustomColors().primary, CustomColors().primaryLight],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
          )
      ),
    ),*/
  }

  Widget _drawerItem({IconData icon, String title, GestureTapCallback onTap}) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
            fontSize: 16.0,
            color: Colors.black54
        ),
      ),
      leading: Icon(icon),
      onTap: onTap,
    );
  }

  Widget _drawerStatusWidget(String status) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        status,
        style: TextStyle(
          color: Colors.green,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
