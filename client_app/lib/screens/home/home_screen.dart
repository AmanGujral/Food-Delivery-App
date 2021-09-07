import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../models/restaurant_model.dart';
import '../../screens/filter/filter_screen.dart';
import '../../size_config.dart';

import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  final List<Restaurant> restaurantsList;
  HomeScreen({this.restaurantsList});
  @override
  Widget build(BuildContext context) {
    /// If you set your home screen as first screen make sure call [SizeConfig().init(context)]
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: buildAppBar(context),
      body: Body(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: SizedBox(),
      title: Column(
        children: [
          Container(height: 4.0,),
          Text(
            "Delivery to".toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .caption
                .copyWith(color: kActiveColor),
          ),
          Text("Montreal, QC")
        ],
      ),
      actions: [
        // Filter Button
        FlatButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FilterScreen(),
            ),
          ),
          child: Icon(Icons.filter_list),
          /*child: Text(
            "Filter",
            style: Theme.of(context).textTheme.bodyText1,
          ),*/
        ),
      ],
    );
  }
}
