import 'package:flutter/material.dart';

class FloatingBadge extends StatefulWidget {
  final String text;
  FloatingBadge({@required this.text});

  @override
  _FloatingBadgeState createState() => _FloatingBadgeState();
}

class _FloatingBadgeState extends State<FloatingBadge> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: Colors.black,
      elevation: 3.0,
      label: Text(
        '\$${widget.text}',
        maxLines: 1,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
      onPressed: () => {},
    );
  }
}
