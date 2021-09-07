import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/widgets/app_drawer.dart';

class DummyNavigation extends StatelessWidget {
  static const String TAG = "/dummyScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dummy'),),
      body: Center(child: Text('This is dummy')),
      drawer: AppDrawer(),
    );
  }
}
