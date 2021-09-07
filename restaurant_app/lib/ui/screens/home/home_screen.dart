import 'package:flutter/material.dart';
import 'package:restaurant_app/colors.dart';
import 'package:restaurant_app/ui/screens/history/history_screen.dart';
import 'file:///D:/Mapp%20Inc/uber_eats/restaurant_app/lib/ui/screens/home/components/bottom_bar.dart';
import 'package:restaurant_app/ui/screens/orders/orders_screen.dart';
import 'package:restaurant_app/ui/screens/quick_edit_menu/quick_edit_menu_screen.dart';
import 'package:restaurant_app/ui/widgets/app_drawer.dart';


import '../../../strings.dart';
class HomeScreen extends StatefulWidget {
  static const String TAG = "/homeScreen";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;  // Currently selected tab
  List<Widget> _tabs = [
    OrdersScreen(),
    HistoryScreen(),
    QuickEditMenuScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors().primary,
        title: Text(
            Strings().statusOnline
        ),
        actions: [
          _helpButton(),
        ],
      ),
      body: _tabs[_currentIndex],
      drawer: AppDrawer(),
      bottomNavigationBar: BottomBar(callBack: (int index) {
        setState(() {
          _currentIndex = index;
        });
        },
      ),
    );
  }

  Widget _helpButton() {
    return MaterialButton(
      onPressed: () => {},
      child: Text(
        'Help',
        style: TextStyle(
            color: Colors.white,
            fontSize: 18.0
        ),
      ),
    );
  }
}
