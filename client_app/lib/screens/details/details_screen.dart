import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:client_app/screens/search/search_screen.dart';

import 'components/body.dart';

class DetailsScreen extends StatelessWidget {
  final int index;
  DetailsScreen({this.index});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: buildAppBar(context),
      body: Body(index : index),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(
          icon: SvgPicture.asset("assets/icons/share.svg"),
          onPressed: () {},
        ),
        IconButton(
          icon: SvgPicture.asset("assets/icons/search.svg"),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchScreen(),
            ),
          ),
        ),
      ],
    );
  }
}
