import 'package:client_app/models/menu_item_model.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class OrderDetailsScreen extends StatelessWidget {
  final int index;
  MenuItem item;
  OrderDetailsScreen({this.index, this.item});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      body: Body(index: index, item: item,),
    );
  }
}
