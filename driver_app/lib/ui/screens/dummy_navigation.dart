import 'package:flutter/material.dart';

class DummyNavigation extends StatefulWidget {
  static const TAG = '/dummyScreen';
  @override
  _DummyNavigationState createState() => _DummyNavigationState();
}

class _DummyNavigationState extends State<DummyNavigation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(child: Center(child: Text('This is a dummy screen'),),),
    );
  }
}
