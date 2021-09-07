import 'package:flutter/material.dart';
import 'package:restaurant_app/colors.dart';
import 'package:restaurant_app/models/menu_item_model.dart';
import 'package:restaurant_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant_app/ui/widgets/app_drawer.dart';

class MenuScreen extends StatefulWidget {
  static const String TAG = "/menuScreen";
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  UserModel _userInstance = UserModel().getInstance();
  List<MenuItem> menuList = [];

  TextEditingController nameController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();

  Future<void> _fetchData() async {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors().primary,
        title: Text("Menu"),
      ),
      body: body(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: CustomColors().primary,
        onPressed: showAlertDialog,
      ),
      drawer: AppDrawer(),
    );
  }

  Widget body() {
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
            return ListTile(
              title: Text(menuList[index].name),
              subtitle: Text(menuList[index].price),
            );
          },
        );
      },
    );
  }

  showAlertDialog() {
    MenuItem item = new MenuItem();
    nameController.clear();
    priceController.clear();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Add Menu Item"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                  //margin: EdgeInsets.only(top: 50.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: CustomColors().primaryLightBg
                  ),
                  child: TextField(
                    controller: nameController,
                    cursorColor: CustomColors().primary,
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                    decoration: InputDecoration(
                      hintText: "Item Name",
                      border: InputBorder.none,
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: CustomColors().primaryLightBg
                  ),
                  child: TextField(
                    controller: priceController,
                    cursorColor: CustomColors().primary,
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                    decoration: InputDecoration(
                      hintText: "Item Price",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              MaterialButton(
                child: Text("Add"),
                elevation: 0.0,
                onPressed: () async => {
                  item.name = nameController.text,
                  item.price = priceController.text,

                  await FirebaseFirestore.instance
                      .collection("Restaurants")
                      .doc(_userInstance.id)
                      .collection("Menu")
                      .add(MenuItem().toMap(item)),

                  setState(() {
                    menuList.add(item);
                    Navigator.pop(context);
                  })
                },
              ),
            ],
          );
        }
    );
  }
}
