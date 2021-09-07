import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/colors.dart';
import 'package:restaurant_app/models/menu_item_model.dart';
import 'package:restaurant_app/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const String TAG = "/orderDetailsScreen";
  Order order;

  OrderDetailsScreen({@required this.order});

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  List<MenuItem> itemList = [];
  Future<dynamic> _fetchOrderData;

  Future<dynamic> _fetchData() async {
    await FirebaseFirestore.instance
        .collection("Orders")
        .doc(widget.order.orderId)
        .collection("Items")
        .get()
        .then((QuerySnapshot snapshot) => {
      snapshot.docs.forEach((doc) {
        itemList.add(MenuItem().fromMap(doc.data()));
      })
    });
  }

  @override
  void initState() {
    _fetchOrderData = _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.order.customerName,
        ),
        leading: BackButton(),
        actions: [
          _helpButton(),
        ],
        backgroundColor: CustomColors().primary,
      ),
      body: body(),
      bottomNavigationBar: _bottomBar(),
    );
  }

  Widget body() {
    return FutureBuilder(
      future: _fetchOrderData,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }
        else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Text(
                  widget.order.customerName,
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20.0
                  ),
                ),
                Text(
                  widget.order.orderNumber ?? 'BX58G',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0
                  ),
                ),
                Divider(color: Colors.black54, thickness: 1.0,),
                itemDetails(item: itemList[0]),
                /*Divider(color: Colors.black54, thickness: 1.0,),
                itemDetails(item: itemList[0]),*/
                /*Divider(color: Colors.black54, thickness: 1.0,),
                itemDetails(),
                Divider(color: Colors.black54, thickness: 1.0,),
                itemDetails(),*/
                Divider(color: Colors.black54, thickness: 1.0,),
                Container(height: 8.0,),
                itemAmount(),
              ],
            ),
          );
        }
      },
    );
  }

  Widget itemDetails({MenuItem item}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Item Quantity and Name
            Text(
              '1 x ${item.name}',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18.0
              ),
            ),

            // Item Price
            Text(
              item.price,
              textAlign: TextAlign.end,
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18.0
              ),
            ),
          ],
        ),

        Container(height: 8.0,),

        // Item Sub Details
        Text(
          'Sub Detail',
          textAlign: TextAlign.start,
          style: TextStyle(
              color: Colors.black54,
              fontSize: 14.0
          ),
        ),

        Text(
          'Sub Detail',
          textAlign: TextAlign.start,
          style: TextStyle(
              color: Colors.black54,
              fontSize: 14.0
          ),
        ),

        Text(
          'Sub Detail',
          textAlign: TextAlign.start,
          style: TextStyle(
              color: Colors.black54,
              fontSize: 14.0
          ),
        ),
      ],
    );
  }

  Widget itemAmount() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Subtotal',
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0
              ),
            ),
            Text(
              widget.order.orderAmount,
              textAlign: TextAlign.end,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0
              ),
            ),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tax',
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0
              ),
            ),
            Text(
              widget.order.orderTax,
              textAlign: TextAlign.end,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0
              ),
            ),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total',
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0
              ),
            ),
            Text(
              widget.order.orderTotalAmount,
              textAlign: TextAlign.end,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _bottomBar() {
    if(widget.order.orderStatus == Order.ORDER_STATUS_NEW) {
      widget.order.orderStatus = Order.ORDER_STATUS_IN_PROGRESS;
      return InkWell(
        onTap: () async => {
          print("Confirm Clicked"),
          await FirebaseFirestore.instance
              .collection("Orders")
              .doc(widget.order.orderId)
              .update(Order().toMap(widget.order))
        },
        child: Container(
          height: 55,
          color: CustomColors().primaryDark,
          child: Center(
            child: Text(
              'Confirm',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }
    else if(widget.order.orderStatus == Order.ORDER_STATUS_IN_PROGRESS){
      widget.order.orderStatus = Order.ORDER_STATUS_READY;
      return InkWell(
        onTap: () async => {
          print("Ready Clicked"),
          await FirebaseFirestore.instance
              .collection("Orders")
              .doc(widget.order.orderId)
              .update(Order().toMap(widget.order))
        },
        child: Container(
          height: 55,
          color: CustomColors().primaryDark,
          child: Center(
            child: Text(
              'Ready',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }
    else {
      return null;
    }
  }

  Widget _helpButton() {
    return MaterialButton(
      onPressed: () => {},
      child: Text(
        'Help',
        style: TextStyle(
            color: Colors.white,
            fontSize: 18.0
        ),
      ),
    );
  }

}
