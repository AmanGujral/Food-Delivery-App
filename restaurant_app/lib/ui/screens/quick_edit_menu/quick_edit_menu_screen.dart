import 'package:flutter/material.dart';
import 'package:restaurant_app/colors.dart';
import 'package:restaurant_app/models/menu_item_model.dart';
import 'package:restaurant_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuickEditMenuScreen extends StatefulWidget {
  @override
  _QuickEditMenuScreenState createState() => _QuickEditMenuScreenState();
}

class _QuickEditMenuScreenState extends State<QuickEditMenuScreen> {
  List<MenuItem> menuList = [];
  UserModel _userInstance = UserModel().getInstance();

  _fetchData() async {
    menuList.clear();
    await FirebaseFirestore.instance.collection("Restaurants")
        .doc(_userInstance.id)
        .collection("Menu")
        .get()
        .then((snapshot) => {
      snapshot.docs.forEach((doc) {
        menuList.add(MenuItem().fromMap(doc.data()));
      })
    });
  }

  @override
  void initState() {
    //_fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchData(),
      builder: (context, snapshot){
        if(snapshot.hasError){
          return Center(child: Text(snapshot.error),);
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }
        return ListView.builder(
            itemCount: menuList.length,
            itemBuilder: (context, index) {
              return menuItem(menuList[index]);
            });
      },
    );
  }

  Widget menuItem(MenuItem item) {
    return ListTile(
      title: Text(
        item.name,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 16.0,
        ),
      ),
      trailing: MaterialButton(
        onPressed: () => {},
        shape: StadiumBorder(side: BorderSide(color: Colors.black54, width: 1.0)),
        color: CustomColors().whiteLight,
        child: item.currentStatus == MenuItem.MENU_ITEM_STATUS_OLD_OUT
            ? soldOutButton()
            : availableButton(),
      ),
    );
  }

  Widget availableButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.check_circle_outline,size: 20.0, color: Colors.green,),
        Container(width: 2.0, height: 0,),
        Text('Available'),
      ],
    );
  }

  Widget soldOutButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.highlight_off, color: Colors.red,),
        Text('Sold Out'),
      ],
    );
  }

}
