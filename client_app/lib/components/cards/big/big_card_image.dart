import 'package:flutter/material.dart';

class BigCardImage extends StatelessWidget {
  const BigCardImage({
    Key key,
    @required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0)),
      ),
      elevation: 5.0,
      margin: EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0)),
          //borderRadius: const BorderRadius.all(Radius.circular(12)),
          image: DecorationImage(
            // for newtowk image use NetworkImage()
            image: NetworkImage(image),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
