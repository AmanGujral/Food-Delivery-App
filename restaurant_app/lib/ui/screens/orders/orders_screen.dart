import 'package:flutter/material.dart';
import 'package:restaurant_app/colors.dart';
import 'package:restaurant_app/models/order_model.dart';
import 'package:restaurant_app/models/user_model.dart';
import 'package:restaurant_app/ui/screens/order_details/order_details_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  UserModel _userInstance = UserModel().getInstance();
  List<Order> ordersNew = [];
  List<Order> ordersInProgress = [];
  List<Order> ordersReady = [];

  _fetchData(){
    ordersNew.add(Order(orderStatus: Order.ORDER_STATUS_NEW, customerName: "Aman", orderNumberOfItems: "2"));

    ordersInProgress.add(Order(orderStatus: Order.ORDER_STATUS_IN_PROGRESS, customerName: "Aman", orderNumberOfItems: "2"));
    ordersInProgress.add(Order(orderStatus: Order.ORDER_STATUS_IN_PROGRESS, customerName: "Louis", orderNumberOfItems: "4"));

    ordersReady.add(Order(orderStatus: Order.ORDER_STATUS_READY, customerName: "Taran", orderNumberOfItems: "1"));

  }

  @override
  void initState() {
    //_userInstance = UserModel().getInstance();
    //_fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference orders = FirebaseFirestore.instance
        .collection('Orders');
        //.where('restaurantId', isEqualTo: _userInstance.id);
        /*.doc(_userInstance.id)
        .collection("Orders");*/

    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: orders.where('restaurantId', isEqualTo: _userInstance.id).snapshots(),
          builder: (context, snapshot) {
            if(snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()),);
            }
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }
            if(snapshot.hasData){
              ordersNew.clear();
              ordersInProgress.clear();
              ordersReady.clear();
              snapshot.data.docs.forEach((doc) {
                Order order = Order().fromMap(doc.data());
                if(order.orderStatus == Order.ORDER_STATUS_NEW){
                  ordersNew.add(order);
                }
                else if(order.orderStatus == Order.ORDER_STATUS_IN_PROGRESS){
                  ordersInProgress.add(order);
                }
                else if(order.orderStatus == Order.ORDER_STATUS_READY){
                  ordersReady.add(order);
                }
              });
            }
            return CustomScrollView(
              physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              slivers: [

                // Heading New()
                _listHeader(Order.ORDER_STATUS_NEW, ordersNew.length),

                // List of New orders
                SliverList(
                  delegate: SliverChildBuilderDelegate((BuildContext context, int index){
                    return InkWell(
                      child: _listItem(order: ordersNew[index], index: index),
                      onTap: () => Navigator.pushNamed(context, OrderDetailsScreen.TAG, arguments: ordersNew[index]),
                    );
                  },
                    childCount: ordersNew.length,
                  ),
                ),

                // Heading In progress()
                _listHeader(Order.ORDER_STATUS_IN_PROGRESS, ordersInProgress.length),

                // List of In Progress orders
                SliverList(
                  delegate: SliverChildBuilderDelegate((BuildContext context, int index){
                    return InkWell(
                      child: _listItem(order: ordersInProgress[index]),
                      onTap: () => Navigator.pushNamed(context, OrderDetailsScreen.TAG, arguments: ordersInProgress[index]),
                    );
                  },
                    childCount: ordersInProgress.length,
                  ),
                ),

                // Heading Ready()
                _listHeader(Order.ORDER_STATUS_READY, ordersReady.length),

                // List of Ready orders
                SliverList(
                  delegate: SliverChildBuilderDelegate((BuildContext context, int index){
                    return InkWell(
                      child: _listItem(order: ordersReady[index]),
                      onTap: () => Navigator.pushNamed(context, OrderDetailsScreen.TAG, arguments: ordersReady[index]),
                    );
                  },
                    childCount: ordersReady.length,
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }

  Widget _listHeader(String heading, int subItems) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        child: Text(
          '$heading ($subItems)',
          style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0
          ),
        ),
      ),
    );
  }

  Widget _listItem({Order order, int index}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: new ListTile(
        title: Wrap(
          children: [
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              elevation: 2.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 4.0),
                child: Text(
                  order.orderNumber,
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18.0
                  ),
                ),
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(left: 4.0, top: 2.0),
          child: Text(
            order.customerName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: order.orderStatus == Order.ORDER_STATUS_NEW
                    ? Colors.white
                    : order.orderStatus == Order.ORDER_STATUS_READY
                    ? Colors.white
                    : Colors.black54,
                fontSize: 16.0
            ),
          ),
        ),
        trailing: order.orderStatus == Order.ORDER_STATUS_NEW
            ? MaterialButton(
          onPressed: () => _confirmOrder(order: order, index: index),
          child: Text('Confirm'),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
          color: Colors.white,
          elevation: 2.0,
        )
            : order.orderStatus == Order.ORDER_STATUS_IN_PROGRESS
            ? MaterialButton(
          onPressed: () => _readyOrder(order: order, index: index),
          child: Text('Ready'),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
          color: Colors.white,
          elevation: 2.0,
        )
            : null,
        tileColor: order.orderStatus == Order.ORDER_STATUS_NEW
            ? CustomColors().primary
            : order.orderStatus == Order.ORDER_STATUS_READY
            ? CustomColors().primaryDark
            : CustomColors().greyWhite,
      ),
    );
  }


  // Called after confirming the order
  _confirmOrder({Order order, int index}){
    setState(() {
      order.orderStatus = Order.ORDER_STATUS_IN_PROGRESS;
      ordersInProgress.add(order);
      ordersNew.remove(order);
      _updateOrder(order: order);
      _acceptOrder(order: order);
      print("Order Confirmed");
    });
  }

  // Called when the order is ready
  _readyOrder({Order order, int index}){
    setState(() {
      order.orderStatus = Order.ORDER_STATUS_READY;
      ordersReady.add(order);
      ordersInProgress.remove(order);
      _updateOrder(order: order);
      print("Order Ready");
    });
  }

  // Add the order to Restaurant's DB after accepting it
  _acceptOrder({Order order}) async {
    await FirebaseFirestore.instance.collection("Restaurants")
        .doc(_userInstance.id)
        .collection("Orders")
        .doc(order.orderId)
        .set(Order().toMap(order));
  }

  // Update the order ex: orderStatus
  _updateOrder({Order order}) async {
    await FirebaseFirestore.instance
        .collection("Orders")
        .doc(order.orderId)
        .update(Order().toMap(order));
    /*await FirebaseFirestore.instance
        .collection("Restaurants")
        .doc(_userInstance.id)
        .collection("Orders")
        .doc(order.orderId)
        .update(Order().toMap(order));*/
  }
}
