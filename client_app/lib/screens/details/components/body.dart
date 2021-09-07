import 'package:flutter/material.dart';
import 'package:client_app/size_config.dart';

import 'featured_items.dart';
import 'iteams.dart';
import 'restaurrant_info.dart';

class Body extends StatelessWidget {
  final int index;

  Body({this.index});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Card(
        elevation: 40.0,
        shadowColor: Color(0xFF454545),
        margin: EdgeInsets.only(top: 4.0, left: 0, right: 0, bottom: 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0))),
        child: Padding(
          padding: const EdgeInsets.only(top: 25.0, left: 0.0, right: 15.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalSpacing(of: 10),
                RestaurantInfo(index : index),
                VerticalSpacing(),
                FeaturedItems(),
                Items(index : index),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
