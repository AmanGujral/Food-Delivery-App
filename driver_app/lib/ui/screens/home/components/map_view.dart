import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_app/models/order_model.dart';
import 'package:driver_app/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as Location;

class MapView extends StatefulWidget {
  static const String LOCATION_SERVICE_DISABLED = 'Location Service Disabled';
  static const String PERMISSION_DENIED = 'Permission Denied';
  static const String PERMISSION_DENIED_FOREVER = 'Permission Denied Forever';
  static const String START_MARKER_ID = 'start';
  static const String DESTINATION_MARKER_ID = 'destination';
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  UserModel _userInstance = UserModel().getInstance();
  Position _currentPosition;
  Coordinates _startPosition;
  Coordinates _destinationPosition;
  Set<Marker> markers = {};
  GoogleMapController _mapController;
  Location.Location location = new Location.Location();
  List<Order> newOrders = [];
  List<String> declinedOrders = [];
  Order currentOrder;
  String distance = '';
  bool listenForOrders = true;
  double bottomContainerHeight;
  bool showCurrentOrderDetails = false;

  PolylinePoints polylinePoints;
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};

  String googleAPIKey = "AIzaSyCCSMnRoXVbSZZ8Nk3gFJmEjvc8xybNr7Q";

  @override
  void initState() {
    super.initState();
    _getInitialLocation();
    //currentOrder = new Order(orderNumber: "57GF4H", restaurantName: "Aman's Restaurant");
  }

  @override
  Widget build(BuildContext context1) {
    CollectionReference orders = FirebaseFirestore.instance
        .collection('Orders');

    showCurrentOrderDetails
        ? bottomContainerHeight = MediaQuery.of(context).size.height * 0.6
        : bottomContainerHeight = MediaQuery.of(context).size.height * 0.1;

    return FutureBuilder(
      future: _getInitialLocation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState ==
            ConnectionState.waiting) {
          print('waiting');
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        else{
          return Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
                    zoom: 15.0,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;

                    location.onLocationChanged.listen((l) {
                      // Start Location Marker
                      /*Marker startMarker = Marker(
                        markerId: MarkerId(MapView.START_MARKER_ID),
                        position: LatLng(
                          l.latitude,
                          l.longitude,
                        ),
                        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
                      );
                      markers.removeWhere((element) => element.markerId == MarkerId(MapView.START_MARKER_ID));
                      markers.add(startMarker);*/
                      _mapController.animateCamera(
                          CameraUpdate.newCameraPosition(
                              CameraPosition(target: LatLng(l.latitude, l.longitude),zoom: 18)));

                    });
                  },
                  markers: markers,
                  polylines: Set<Polyline>.of(polylines.values),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  compassEnabled: false,
                  mapToolbarEnabled: false,
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: true,
                ),

                Positioned(
                  height: MediaQuery.of(context).size.width * 0.13,
                  width: MediaQuery.of(context).size.width * 0.13,
                  bottom: MediaQuery.of(context).size.height * 0.15,
                  right: MediaQuery.of(context).size.width * 0.05,
                  child: FloatingActionButton(
                    backgroundColor: Colors.black,
                    child: Icon(Icons.my_location, size: MediaQuery.of(context).size.width * 0.065,),
                    onPressed: () => _moveToCurrentLocation(),
                  ),
                ),

                _userInstance.currentStatus == UserModel.DRIVER_STATUS_ONLINE && listenForOrders
                    ? StreamBuilder<QuerySnapshot>(
                    stream: declinedOrders.isNotEmpty ?
                    orders
                        .where("orderStatus", isEqualTo: Order.ORDER_STATUS_READY)
                        .where("orderId", whereNotIn: declinedOrders)
                        .limit(1).snapshots()
                        : orders
                        .where("orderStatus", isEqualTo: Order.ORDER_STATUS_READY)
                        .limit(1).snapshots(),
                    builder: (context, snapshot) {
                      if(snapshot.hasError) {
                        print("Error fetching orders");
                        //return Center(child: Text(snapshot.error.toString()),);
                      }
                      if(snapshot.connectionState == ConnectionState.waiting){
                        print("Waiting to fetch orders");
                        //return Center(child: CircularProgressIndicator(),);
                      }
                      if(snapshot.hasData){
                        newOrders.clear();
                        snapshot.data.docs.forEach((doc) {
                          newOrders.add(Order().fromMap(doc.data()));
                        });
                        if(newOrders.isNotEmpty) {
                          return Align(
                            alignment: Alignment.bottomCenter,
                            child: _newOrderPopUp(newOrders[0]),
                          );
                        }
                        else {
                          return _bottomBar();
                        }
                      }
                      else{
                        return _bottomBar();
                      }
                    }
                )
                    : Container(height: 0,),

                currentOrder != null
                    ? _bottomBar()
                    : Container(height: 0),
              ]
          );
        }
      },
    );
  }

  Widget _bottomBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: currentOrder == null
      // Searching for new orders
          ? Container(
        height: MediaQuery.of(context).size.height * 0.1,
        width: double.infinity,
        color: Colors.black,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'Searching for orders...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: LinearProgressIndicator(
                backgroundColor: Colors.black,
                minHeight: 2.0,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ],
        ),
      )
      //Already have a current order
          : Container(
        height: bottomContainerHeight,
        width: double.infinity,
        color: Colors.black,
        child: showCurrentOrderDetails
            ? showOrderDetails()
            : InkWell(
          onTap: _openOrderDetails,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                margin: EdgeInsets.only(left: 10.0, right: 10.0),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                elevation: 2.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 4.0),
                  child: Text(
                    currentOrder.orderNumber,
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18.0
                    ),
                  ),
                ),
              ),

              Expanded(
                child: Text(
                  currentOrder.orderStatus == Order.ORDER_STATUS_PICKED_UP
                      ? currentOrder.customerName
                      : currentOrder.restaurantName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),

              Container(width: 10.0),
            ],
          ),
        ),
      ),
    );
  }

  _openOrderDetails() {
    setState(() {
      showCurrentOrderDetails = true;
      //bottomContainerHeight = MediaQuery.of(context).size.height * 0.8;
    });
  }

  _closeOrderDetails() {
    setState(() {
      showCurrentOrderDetails = false;
    });
  }

  Widget showOrderDetails() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: IconButton(
              onPressed: _closeOrderDetails,
              icon: Icon(Icons.keyboard_arrow_down, color: Colors.white70,),
            ),
          ),
          Row(
            children: [
              Card(
                margin: EdgeInsets.only(left: 10.0, right: 10.0),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                elevation: 2.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 4.0),
                  child: Text(
                    currentOrder.orderNumber,
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18.0
                    ),
                  ),
                ),
              ),

              Expanded(
                child: Text(
                  currentOrder.orderStatus == Order.ORDER_STATUS_PICKED_UP
                      ? currentOrder.customerName
                      : currentOrder.restaurantName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),

              Container(width: 10.0),
            ],
          ),

          Container(height: 20.0,),

          Expanded(
            child: Text(
              currentOrder.orderStatus == Order.ORDER_STATUS_PICKED_UP
                  ? currentOrder.customerAddress
                  : currentOrder.restaurantAddress,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 18.0,
              ),
            ),
          ),

          Divider(height: 1.0, thickness: 1.0, color: Colors.white38,),



          Align(
            alignment: Alignment.bottomCenter,
            child: currentOrder.orderStatus == Order.ORDER_STATUS_PICKED_UP
                ? MaterialButton(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              minWidth: double.infinity,
              onPressed: _completeCurrentOrder,
              shape: BeveledRectangleBorder(side: BorderSide(color: Colors.green, width: 1.0)),
              child: Text(
                "Order Delivered",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 18.0,
                ),
              ),
            )
                : MaterialButton(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              minWidth: double.infinity,
              onPressed: _pickupOrder,
              shape: BeveledRectangleBorder(side: BorderSide(color: Colors.green, width: 2.0)),
              child: Text(
                "Order Picked Up",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _getInitialLocation() async {
    bool _serviceEnabled;
    LocationPermission _permission;

    _serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if(!_serviceEnabled){
      // Location Services are Disabled
      return Future.error(MapView.LOCATION_SERVICE_DISABLED);
    }
    else{
      // Location Services are Enabled
      _permission = await Geolocator.checkPermission();


      // CHECK LOCATION PERMISSIONS
      if(_permission == LocationPermission.denied){
        // Location Permissions are Denied
        _permission = await Geolocator.requestPermission();

        if(_permission == LocationPermission.denied){
          // Location Permissions are Denied again by the user
          return Future.error(MapView.PERMISSION_DENIED);
        }
        else if(_permission == LocationPermission.deniedForever){
          // Location Permissions are Denied Forever by the user
          return Future.error(MapView.PERMISSION_DENIED_FOREVER);
        }
        else{
          // Location Permissions are Provided by the user
          await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
              .then((Position position) {
            _currentPosition = position;
          });
        }
      }
      else if(_permission == LocationPermission.deniedForever){
        // Location Permissions are Denied Forever
        return Future.error(MapView.PERMISSION_DENIED_FOREVER);
      }
      else{
        // Location Permissions are Provided
        await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
            .then((Position position) {
          _currentPosition = position;
        });
      }
    }
  }

  void _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;

        _mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
              zoom: 15.0,
            )
        ));
      });
    });
  }

  _moveToCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      _mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 15.0,
          )
      ));
    });
  }

  _getRoute(String address) async {
    markers.clear();
    polylineCoordinates.clear();

    _getCurrentLocation();

    try {
      //var addresses = await Geocoder.local.findAddressesFromQuery('2220 Rue Mousseau, Montreal');
      //var addresses2 = await Geocoder.local.findAddressesFromQuery('592 Mercier Avenue, Montreal');
      var addresses = await Geocoder.local.findAddressesFromQuery(address);

      var destinationAddress = addresses.first;
      Coordinates startCoordinates = new Coordinates(_currentPosition.latitude, _currentPosition.longitude);

      // Get start coordinates
      _startPosition = startCoordinates;
      //_startPosition = addresses2.first.coordinates;

      // Get destination coordinates
      _destinationPosition = destinationAddress.coordinates;

      // Start Location Marker
      /*Marker startMarker = Marker(
        markerId: MarkerId(MapView.START_MARKER_ID),
        position: LatLng(
          _startPosition.latitude,
          _startPosition.longitude,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      );*/

      // Destination Location Marker
      Marker destinationMarker = Marker(
        markerId: MarkerId(MapView.DESTINATION_MARKER_ID),
        position: LatLng(
          _destinationPosition.latitude,
          _destinationPosition.longitude,
        ),
        icon: BitmapDescriptor.defaultMarker,
      );

      // Add markers to the list
      //markers.add(startMarker);
      markers.add(destinationMarker);


      /*// Calculating to check that
      // southwest coordinate <= northeast coordinate
      if (_startPosition.latitude <= _destinationPosition.latitude) {
        _southwestCoordinates = _startPosition;
        _northeastCoordinates = _destinationPosition;
      } else {
        _southwestCoordinates = _destinationPosition;
        _northeastCoordinates = _startPosition;
      }*/

      LatLngBounds bound;
      if (_destinationPosition.latitude > _startPosition.latitude &&
          _destinationPosition.longitude > _startPosition.longitude) {
        bound = LatLngBounds(
            southwest: LatLng(_startPosition.latitude, _startPosition.longitude),
            northeast: LatLng(_destinationPosition.latitude, _destinationPosition.longitude));
      } else if (_destinationPosition.longitude > _startPosition.longitude) {
        bound = LatLngBounds(
            southwest: LatLng(_destinationPosition.latitude, _startPosition.longitude),
            northeast: LatLng(_startPosition.latitude, _destinationPosition.longitude));
      } else if (_destinationPosition.latitude > _startPosition.latitude) {
        bound = LatLngBounds(
            southwest: LatLng(_startPosition.latitude, _destinationPosition.longitude),
            northeast: LatLng(_destinationPosition.latitude, _startPosition.longitude));
      } else {
        bound = LatLngBounds(
            southwest: LatLng(_destinationPosition.latitude, _destinationPosition.longitude),
            northeast: LatLng(_startPosition.latitude, _startPosition.longitude));
      }


      // Accommodate the two locations within the
      // camera view of the map
      _mapController.animateCamera(
        CameraUpdate.newLatLngBounds(
          bound,
          100.0, // padding
        ),
      );

      _createPolylines(_startPosition, _destinationPosition);

      double totalDistance = 0.0;
      for (int i = 0; i < polylineCoordinates.length - 1; i++) {
        totalDistance += _coordinateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i + 1].latitude,
          polylineCoordinates[i + 1].longitude,
        );
      }
      print('Distance : $totalDistance');
      distance = totalDistance.toStringAsFixed(2);

      setState(() {

      });
    } catch (e) {
      print(e);
    }
  }

  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  _createPolylines(Coordinates start, Coordinates destination) async {
    // Initializing PolylinePoints
    polylinePoints = PolylinePoints();

    // Generating the list of coordinates to be used for
    // drawing the polylines
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPIKey, // Google Maps API Key
      PointLatLng(start.latitude, start.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.transit,
    );

    // Adding the coordinates to the list
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    // Defining an ID
    PolylineId id = PolylineId('poly');

    // Initializing Polyline
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.teal,
      points: polylineCoordinates,
      width: 5,
    );

    // Adding the polyline to the map
    polylines[id] = polyline;
  }

  Widget _newOrderPopUp(Order order) {
    return Container(
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(10.0),
      ),
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: EdgeInsets.only(top: 8.0),
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white60, width: 2.0),
                borderRadius: BorderRadius.circular(50.0),
                color: Colors.black
            ),
            child: Text(
              "\$7.00",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0
              ),
            ),
          ),

          Text(
            order.customerName,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 22.0,
            ),
          ),

          Text(
            "Total Distance : 2.7kms",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 18.0,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.red,
                    width: 2.0,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                onPressed: () => _declineOrder(order),
                child: Text(
                  "Decline",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18.0,
                  ),
                ),
              ),

              MaterialButton(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.green,
                    width: 2.0,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                onPressed: () => _acceptOrder(order),
                child: Text(
                  "Accept",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _acceptOrder(Order order) async {
    currentOrder = order;
    //currentOrder.orderStatus = Order.ORDER_STATUS_PICKED_UP;
    currentOrder.driverId = _userInstance.id;
    currentOrder.driverDeliveryStatus = Order.DELIVERY_STATUS_ON_ROUTE;

    await FirebaseFirestore.instance
        .collection("Orders")
        .doc(currentOrder.orderId)
        .update(Order().toMap(currentOrder));

    newOrders.clear();
    listenForOrders = false;

    _getRoute(currentOrder.restaurantAddress);
    //_getRoute('2220 Rue Mousseau, Montreal');

    /*setState(() {

    });*/
  }

  _declineOrder(Order order) {
    declinedOrders.add(order.orderId);
    setState(() {
      newOrders.clear();
      listenForOrders = true;
    });
  }

  _pickupOrder() async {
    currentOrder.driverDeliveryStatus = Order.DELIVERY_STATUS_PICKED_UP;
    currentOrder.orderStatus = Order.ORDER_STATUS_PICKED_UP;

    await FirebaseFirestore.instance
        .collection("Orders")
        .doc(currentOrder.orderId)
        .update(Order().toMap(currentOrder));

    _getRoute(currentOrder.customerAddress);
  }

  _completeCurrentOrder() async {
    currentOrder.orderStatus = Order.ORDER_STATUS_COMPLETED;
    currentOrder.driverDeliveryStatus = Order.DELIVERY_STATUS_DELIVERED;

    await FirebaseFirestore.instance
        .collection("Orders")
        .doc(currentOrder.orderId)
        .update(Order().toMap(currentOrder));

    listenForOrders = true;
    currentOrder = null;
    markers.clear();
    polylines.clear();

    setState(() {

    });

  }
}
