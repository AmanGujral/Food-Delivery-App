import 'package:client_app/models/menu_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:client_app/components/buttons/primary_button.dart';
import 'package:client_app/constants.dart';
import 'package:client_app/size_config.dart';
import 'package:provider/provider.dart';
import '../../../models/order_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../models/restaurant_model.dart';
import 'order_item_card.dart';

class Body extends StatefulWidget {
  final int index;
  MenuItem item;
  Body({this.index, this.item});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final FirebaseFirestore _fs = FirebaseFirestore.instance;

  Future<dynamic> _sendOrderData({User user}) async {
    String _docId;
    print(widget.index);
    print(Restaurant.allRestaurantsList[widget.index].id);
    /*await _fs
        .collection("Restaurants")
        .where("id", isEqualTo: Restaurant.allRestaurantsList[widget.index].id)
        .get()
        .then(
          (QuerySnapshot snapshot) => {
            snapshot.docs.forEach((f) {
              _docId = f.reference.id;
            }),
          },
        );*/
    Order _newOrder = Order(
      customerAddress: "2455 Dollard Avenue, Lasalle",
      customerId: user.uid,
      customerName: "James",
      customerPhone: "514-222-2222",
      orderId: "",
      orderStatus: "New",
      orderNumber: "4FG7J9",
      orderAmount: widget.item.price,
      orderTax: "3.99",
      orderNumberOfItems: "1",
      orderInstructions: "Less Spicy",
      orderTotalAmount: (double.parse(widget.item.price) + double.parse("3.99")).toString(),
      restaurantName: Restaurant.allRestaurantsList[widget.index].name,
      restaurantId: Restaurant.allRestaurantsList[widget.index].id,
      restaurantAddress: Restaurant.allRestaurantsList[widget.index].address,
    );

    //Map<String, dynamic> _newOrderMap = Order().toMap(_newOrder);
    /*_fs
        .collection("Restaurants")
        .doc(_docId)
        .collection("Orders")
        .doc()
        .set(_newOrderMap);*/

    //Add Order to DB
    await _fs
        .collection("Orders")
        .add(Order().toMap(_newOrder))
        .then((DocumentReference reference) => {
      _newOrder.orderId = reference.id
    });

    //Add Order Id to the order that we just added
    await _fs.collection("Orders")
        .doc(_newOrder.orderId)
        .update(Order().toMap(_newOrder));

    //Add Items to the order that we just added
    await _fs.collection("Orders")
        .doc(_newOrder.orderId)
        .collection("Items")
        .add(MenuItem().toMap(widget.item));
    return null;
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          children: [
            VerticalSpacing(),
            // List of cart items
            ...List.generate(
              demoItems.length,
                  (index) => Padding(
                padding:
                const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                child: OrderedItemCard(
                  title: demoItems[index]["title"],
                  description:
                  "Shortbread, chocolate turtle cookies, and red velvet.",
                  numOfItem: demoItems[index]["numOfItem"],
                  price: demoItems[index]["price"].toDouble(),
                ),
              ),
            ),
            buildPriceRow(text: "Subtotal", price: 28.0),
            VerticalSpacing(of: 10),
            buildPriceRow(text: "Delivery", price: 0),
            VerticalSpacing(of: 10),
            buildTotal(price: 20),
            VerticalSpacing(of: 40),
            PrimaryButton(
              text: "Checkout (\$20.10)",
              press: () {
                _sendOrderData(user: user);
              },
            ),
          ],
        ),
      ),
    );
  }

  Row buildTotal({@required double price}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text.rich(
          TextSpan(
            text: "Total ",
            style: kBodyTextStyle.copyWith(
                color: kMainColor, fontWeight: FontWeight.w500),
            children: [
              TextSpan(
                text: "(incl. VAT)",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        Text(
          "\$$price",
          style: kBodyTextStyle.copyWith(
              color: kMainColor, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Row buildPriceRow({@required String text, @required double price}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: kBodyTextStyle.copyWith(color: kMainColor),
        ),
        Text(
          "\$$price",
          style: kBodyTextStyle.copyWith(color: kMainColor),
        )
      ],
    );
  }
}

const List<Map> demoItems = [
  {
    "title": "Cookie Sandwich",
    "price": 7.4,
    "numOfItem": 1,
  },
  {
    "title": "Combo Burger",
    "price": 12,
    "numOfItem": 1,
  },
  {
    "title": "Oyster Dish",
    "price": 8.6,
    "numOfItem": 2,
  },
];
