

import 'package:flutter/material.dart';
import 'package:restaurant_app/colors.dart';

class BottomBar extends StatefulWidget {
  final Function(int) callBack;
  BottomBar({@required this.callBack});

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    _onTabClicked(int index) {
      setState(() {
        _currentIndex = index;
        widget.callBack(index);
      });
    }
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.shifting,
      selectedItemColor: CustomColors().primary,
      unselectedItemColor: CustomColors().grey,
      onTap: _onTabClicked,
      items: [
        new BottomNavigationBarItem(
          icon: Icon(Icons.list_alt),
          label: "Orders",
        ),
        new BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: "History",
        ),
        new BottomNavigationBarItem(
          icon: Icon(Icons.edit_outlined),
          label: "Edit",
        ),
      ],
    );
  }
}