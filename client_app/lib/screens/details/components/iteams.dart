import 'package:client_app/models/menu_item_model.dart';
import 'package:client_app/models/restaurant_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:client_app/screens/addToOrder/add_to_order_screen.dart';
import '../../../components/cards/iteam_card.dart';
import '../../../constants.dart';

class Items extends StatefulWidget {
  final int index;
  Items({this.index});

  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  List<MenuItem> itemList = [];
  Future<dynamic> _getData;

  Future<dynamic> _getMenuData() async {
    await FirebaseFirestore.instance.collection("Restaurants")
        .doc(Restaurant.allRestaurantsList[widget.index].id)
        .collection("Menu")
        .get()
        .then((QuerySnapshot snapshot) => {
      snapshot.docs.forEach((doc) {
        itemList.add(MenuItem().fromMap(doc.data()));
      })
    });
  }

  @override
  void initState() {
    _getData = _getMenuData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getData,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }
        else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultTabController(
                length: demoTabs.length,
                child: TabBar(
                  isScrollable: true,
                  unselectedLabelColor: kMainColor.withOpacity(0.54),
                  labelStyle: kH3TextStyle,
                  onTap: (value) {
                    // you will get selected tab index
                  },
                  tabs: demoTabs,
                ),
              ),
              // VerticalSpacing(),
              ...List.generate(
                demoData.length,
                    (index) => Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding - 5, vertical: kDefaultPadding / 2),

                  child: ItemCard(
                    title: itemList[index].name ?? "Cookie Sandwich",
                    description: itemList[index].description ?? "Shortbread, chocolate turtle cookies, and red velvet.",
                    image: demoData[index]["image"],
                    foodType: demoData[index]['foodType'],
                    price: itemList[index].price ?? "7.5",
                    priceRange: demoData[index]["priceRange"],
                    press: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddToOrderScrreen(index: widget.index, item: itemList[index],),
                      ),
                    ),
                  ),
                  /*child: ItemCard(
                    title: demoData[index]["title"],
                    description: demoData[index]["description"],
                    image: demoData[index]["image"],
                    foodType: demoData[index]['foodType'],
                    price: demoData[index]["price"],
                    priceRange: demoData[index]["priceRange"],
                    press: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddToOrderScrreen(index: widget.index),
                      ),
                    ),
                  ),*/
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

final List<Tab> demoTabs = <Tab>[
  Tab(
    child: Text('Most Populars'),
  ),
  Tab(
    child: Text('Beef & Lamb'),
  ),
  Tab(
    child: Text('Seafood'),
  ),
  Tab(
    child: Text('Appetizers'),
  ),
  Tab(
    child: Text('Dim Sum'),
  ),
];

final List<Map<String, dynamic>> demoData = List.generate(
  3,
      (index) => {
    "image": "assets/images/featured _items_${index + 1}.png",
    "title": "Cookie Sandwich",
    "description": "Shortbread, chocolate turtle cookies, and red velvet.",
    "price": 7.4,
    "foodType": "Chinese",
    "priceRange": "\$" * 2,
  },
);
