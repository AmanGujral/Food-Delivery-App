import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:client_app/screens/orderDetails/order_details_screen.dart';
import 'package:client_app/screens/profile/profile_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/search/search_screen.dart';
import '../size_config.dart';
import '../models/restaurant_model.dart';
import '../constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    Key key,
  }) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<Restaurant> restaurantsList = [];
  final FirebaseFirestore _fs = FirebaseFirestore.instance;
  Future<dynamic> initFireStoreData;

  @override
  void initState() {
    initFireStoreData = _initFireStoreData();
    super.initState();
  }

  Future<dynamic> _initFireStoreData() async {
    restaurantsList.clear();
    await _fs.collection("Restaurants").get().then((QuerySnapshot snapshot) => {
          snapshot.docs.forEach((doc) async {
            restaurantsList.add(Restaurant().fromMap(doc.data()));
          })
        });
    await Restaurant.setAllRestaurantsList(allRestaurants: restaurantsList);
    print(Restaurant.allRestaurantsList[0].name);
    return null;
  }

  // Bydefault first one is selected
  int _selectedIndex = 0;

  // List of nav items
  List<Map<String, dynamic>> _navitems = [
    {"icon": "assets/icons/home.svg", "title": "Home"},
    {"icon": "assets/icons/search.svg", "title": "Search"},
    {"icon": "assets/icons/order.svg", "title": "Orders"},
    {"icon": "assets/icons/profile.svg", "title": "Profile"},
  ];

// Screens
  List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    OrderDetailsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    /// If you set your home screen as first screen make sure call [SizeConfig().init(context)]
    SizeConfig().init(context);
    return FutureBuilder(
        future: initFireStoreData,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting)
            return Scaffold(body: Center(
              child: CupertinoActivityIndicator(),
            ),) ;
          if (snap.hasError)
            return Scaffold(body: Center(
              child: Text("An Error Occur. Please Contact The Support Team"),
            ),) ;
          return Scaffold(
            body: _screens[_selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (value) {
                setState(() {
                  _selectedIndex = value;
                });
              },
              currentIndex: _selectedIndex,
              selectedItemColor: kActiveColor,
              unselectedItemColor: kBodyTextColor,
              type: BottomNavigationBarType.shifting,
              //activeColor: kActiveColor,
              //inactiveColor: kBodyTextColor,
              items: List.generate(
                _navitems.length,
                (index) => BottomNavigationBarItem(
                  icon: buildSvgIcon(
                      src: _navitems[index]['icon'],
                      isActive: _selectedIndex == index),
                  title: Text(
                    _navitems[index]["title"],
                  ),
                ),
              ),
            ),
          );
        });
  }

  SvgPicture buildSvgIcon({@required String src, bool isActive = false}) {
    return SvgPicture.asset(
      src,
      height: 30,
      width: 30,
      color: isActive ? kActiveColor : kBodyTextColor,
    );
  }
}
