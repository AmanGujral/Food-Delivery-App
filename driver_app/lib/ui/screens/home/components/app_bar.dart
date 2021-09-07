import 'package:driver_app/ui/screens/home/components/floating_badge.dart';
import 'package:flutter/material.dart';

Widget Appbar() {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    leading: _drawerIcon(),
    actions: [
      _helpIcon(),
    ],
    title: FloatingBadge(text: '100.23',),
    centerTitle: true,
  );
}

Widget _drawerIcon() {
  return Builder(
    builder: (context) =>
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: FloatingActionButton(
            child: Icon(Icons.menu),
            elevation: 3.0,
            backgroundColor: Colors.black,
            onPressed: () => {Scaffold.of(context).openDrawer()},
          ),
        ),
  );
}

Widget _helpIcon() {
  return Builder(
    builder: (context) =>
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: FloatingActionButton(
            child: Text(
              '?',
              style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.06),
            ),
            elevation: 3.0,
            backgroundColor: Colors.black,
            onPressed: () => {},
          ),
        ),
  );
}
