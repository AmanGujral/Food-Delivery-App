import 'package:client_app/models/menu_item_model.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class AddToOrderScrreen extends StatelessWidget {
  final int index;
  MenuItem item;
  AddToOrderScrreen({this.index, this.item});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(context),
      body: Body(index: index, item: item),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FlatButton(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(100))),
          padding: EdgeInsets.zero,
          color: Colors.black.withOpacity(0.5),
          child: Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
