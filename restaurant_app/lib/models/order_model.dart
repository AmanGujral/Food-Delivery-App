
class Order {
  String _orderId;                    // Order Id
  String _orderNumber;                // Order Number
  String _orderAmount;                // Amount before Tax, Discount and Tips
  String _orderTax;                   // Tax
  String _orderDiscount;              // Discount
  String _orderTotalAmount;           // Total Amount after adding Tax, Discount and Tips
  String _orderNumberOfItems;         // Number of distinct items from the menu
  String _orderStatus;                // Order Status - New, Cancelled, In Progress, Ready, Completed
  String _orderDuration;              // Preparation Time
  String _orderDate;                  // Date on which order was placed
  String _orderTime;                  // Time at which order was placed
  String _orderTimestamp;             // Timestamp of the order - to sort the orders in Database based on First In First Out
  String _orderInstructions;          // Special Instructions by the Customer for restaurant - Cooking Instructions, etc.

  String _customerId;                 // Customer Id
  String _customerName;               // Customer Name
  String _customerPhone;              // Customer Phone number
  String _customerAddress;            // Customer Address or Delivery Address

  String _restaurantId;               // Restaurant Id
  String _restaurantName;             // Restaurant Name
  String _restaurantAddress;          // Restaurant Address

  String _driverId;                   // Driver Id
  String _driverName;                 // Driver Name
  String _driverPhone;                // Driver Phone number
  String _driverImageUrl;             // Driver Image Url
  String _driverBaseFare;             // Driver Base Fare for current delivery
  String _driverBonusFare;            // Driver Bonus Fare for current delivery - Surge
  String _driverTip;                  // Customer Tip for the driver
  String _driverTotalFare;            // Driver Total Fare including BaseFare, BonusFare and Tip
  String _driverDeliveryStatus;       // Status of the delivery driver - OnRoute, WaitingForPickup, PickedUp, Delivered, Undelivered
  String _driverInstructions;         // Special Instructions by the Customer for driver - Drop off Instructions, etc.


  //<-- @orderStatus can only have one of these values -->
  static const String ORDER_STATUS_NEW = "New";
  static const String ORDER_STATUS_IN_PROGRESS = "In Progress";
  static const String ORDER_STATUS_READY = "Ready";
  static const String ORDER_STATUS_PICKED_UP = "Picked Up";
  static const String ORDER_STATUS_CANCELLED = "Cancelled";
  static const String ORDER_STATUS_COMPLETED = "Completed";
  //<---------------------------------------------------->

  //<-- @driverDeliveryStatus can only have one of these values -->
  static const String DELIVERY_STATUS_ON_ROUTE = "On Route";
  static const String DELIVERY_STATUS_IN_WAITING_FOR_PICKUP = "Waiting For Pickup";
  static const String DELIVERY_STATUS_PICKED_UP = "Picked Up";
  static const String DELIVERY_STATUS_DELIVERED = "Delivered";
  static const String DELIVERY_STATUS_UNDELIVERED = "Undelivered";
  //<------------------------------------------------------------->

  Order({
    String orderId,
    String orderNumber,
    String orderAmount,
    String orderTax,
    String orderDiscount,
    String orderTotalAmount,
    String orderNumberOfItems,
    String orderStatus,
    String orderDuration,
    String orderDate,
    String orderTime,
    String orderTimestamp,
    String orderInstructions,

    String customerId,
    String customerName,
    String customerPhone,
    String customerAddress,

    String restaurantId,
    String restaurantName,
    String restaurantAddress,

    String driverId,
    String driverName,
    String driverPhone,
    String driverImageUrl,
    String driverBaseFare,
    String driverBonusFare,
    String driverTip,
    String driverTotalFare,
    String driverDeliveryStatus,
    String driverInstructions,
  })
  {
    this._orderId = orderId ?? '';
    this._orderNumber = orderNumber ?? '';
    this._orderAmount = orderAmount ?? '';
    this._orderTax = orderTax ?? '';
    this._orderDiscount = orderDiscount ?? '';
    this._orderTotalAmount = orderTotalAmount ?? '';
    this._orderNumberOfItems = orderNumberOfItems ?? '';
    this._orderStatus = orderStatus ?? '';
    this._orderDuration = orderDuration ?? '';
    this._orderDate = orderDate ?? '';
    this._orderTime = orderTime ?? '';
    this._orderTimestamp = orderTimestamp ?? '';
    this._orderInstructions = orderInstructions ?? '';

    this._customerId = customerId ?? '';
    this._customerName = customerName ?? '';
    this._customerPhone = customerPhone ?? '';
    this._customerAddress = customerAddress ?? '';

    this._restaurantId = restaurantId ?? '';
    this._restaurantName = restaurantName ?? '';
    this._restaurantAddress = restaurantAddress ?? '';

    this._driverId = driverId ?? '';
    this._driverName = driverName ?? '';
    this._driverPhone = driverPhone ?? '';
    this._driverImageUrl = driverImageUrl ?? '';
    this._driverBaseFare = driverBaseFare ?? '';
    this._driverBonusFare = driverBonusFare ?? '';
    this._driverTip = driverTip ?? '';
    this._driverTotalFare = driverTotalFare ?? '';
    this._driverDeliveryStatus = driverDeliveryStatus ?? '';
    this._driverInstructions = driverInstructions ?? '';
  }

  Map<String, dynamic> toMap(Order order) {
    Map<String, dynamic> map = {
      "orderId": order.orderId ?? "",
      "orderNumber": order.orderNumber ?? "",
      "orderAmount": order.orderAmount ?? "",
      "orderTax": order.orderTax ?? "",
      "orderDiscount": order.orderDiscount ?? "",
      "orderTotalAmount": order.orderTotalAmount ?? "",
      "orderNumberOfItems": order.orderNumberOfItems ?? "",
      "orderStatus": order.orderStatus ?? "",
      "orderDuration": order.orderDuration ?? "",
      "orderDate": order.orderDate ?? "",
      "orderTime": order.orderTime ?? "",
      "orderTimestamp": order.orderTimestamp ?? "",
      "orderInstructions": order.orderInstructions ?? "",

      "customerId": order.customerId ?? "",
      "customerName": order.customerName ?? "",
      "customerPhone": order.customerPhone ?? "",
      "customerAddress": order.customerAddress ?? "",

      "restaurantId": order.restaurantId ?? "",
      "restaurantName": order.restaurantName ?? "",
      "restaurantAddress": order.restaurantAddress ?? "",

      "driverId": order.driverId ?? "",
      "driverName": order.driverName ?? "",
      "driverPhone": order.driverPhone ?? "",
      "driverImageUrl": order.driverImageUrl ?? "",
      "driverBaseFare": order.driverBaseFare ?? "",
      "driverBonusFare": order.driverBonusFare ?? "",
      "driverTip": order.driverTip ?? "",
      "driverTotalFare": order.driverTotalFare ?? "",
      "driverDeliveryStatus": order.driverDeliveryStatus ?? "",
      "driverInstructions": order.driverInstructions ?? "",
    };
    return map;
  }

  Order fromMap(Map<String, dynamic> map) {
    return new Order(
      orderId: map["orderId"] ?? '',
      orderNumber: map["orderNumber"] ?? '',
      orderAmount: map["orderAmount"] ?? '',
      orderTax: map["orderTax"] ?? '',
      orderDiscount: map["orderDiscount"] ?? '',
      orderTotalAmount: map["orderTotalAmount"] ?? '',
      orderNumberOfItems: map["orderNumberOfItems"] ?? '',
      orderStatus: map["orderStatus"] ?? '',
      orderDuration: map["orderDuration"] ?? '',
      orderDate: map["orderDate"] ?? '',
      orderTime: map["orderTime"] ?? '',
      orderTimestamp: map["orderTimestamp"] ?? '',
      orderInstructions: map["orderInstructions"] ?? '',

      customerId: map["customerId"] ?? '',
      customerName: map["customerName"] ?? '',
      customerPhone: map["customerPhone"] ?? '',
      customerAddress: map["customerAddress"] ?? '',

      restaurantId: map["restaurantId"] ?? '',
      restaurantName: map["restaurantName"] ?? '',
      restaurantAddress: map["restaurantAddress"] ?? '',

      driverId: map["driverId"] ?? '',
      driverName: map["driverName"] ?? '',
      driverImageUrl: map["driverImageUrl"] ?? '',
      driverPhone: map["driverPhone"] ?? '',
      driverBaseFare: map["driverBaseFare"] ?? '',
      driverBonusFare: map["driverBonusFare"] ?? '',
      driverTip: map["driverTip"] ?? '',
      driverTotalFare: map["driverTotalFare"] ?? '',
      driverDeliveryStatus: map["driverDeliveryStatus"],
      driverInstructions: map["driverInstructions"] ?? '',

    );
  }


  String get driverDeliveryStatus => _driverDeliveryStatus;

  set driverDeliveryStatus(String value) {
    _driverDeliveryStatus = value;
  }

  String get driverInstructions => _driverInstructions;

  set driverInstructions(String value) {
    _driverInstructions = value;
  }

  String get driverTotalFare => _driverTotalFare;

  set driverTotalFare(String value) {
    _driverTotalFare = value;
  }

  String get driverTip => _driverTip;

  set driverTip(String value) {
    _driverTip = value;
  }

  String get driverBonusFare => _driverBonusFare;

  set driverBonusFare(String value) {
    _driverBonusFare = value;
  }

  String get driverBaseFare => _driverBaseFare;

  set driverBaseFare(String value) {
    _driverBaseFare = value;
  }

  String get driverImageUrl => _driverImageUrl;

  set driverImageUrl(String value) {
    _driverImageUrl = value;
  }

  String get driverPhone => _driverPhone;

  set driverPhone(String value) {
    _driverPhone = value;
  }

  String get driverName => _driverName;

  set driverName(String value) {
    _driverName = value;
  }

  String get driverId => _driverId;

  set driverId(String value) {
    _driverId = value;
  }

  String get restaurantAddress => _restaurantAddress;

  set restaurantAddress(String value) {
    _restaurantAddress = value;
  }

  String get restaurantName => _restaurantName;

  set restaurantName(String value) {
    _restaurantName = value;
  }

  String get restaurantId => _restaurantId;

  set restaurantId(String value) {
    _restaurantId = value;
  }

  String get customerAddress => _customerAddress;

  set customerAddress(String value) {
    _customerAddress = value;
  }

  String get customerPhone => _customerPhone;

  set customerPhone(String value) {
    _customerPhone = value;
  }

  String get customerName => _customerName;

  set customerName(String value) {
    _customerName = value;
  }

  String get customerId => _customerId;

  set customerId(String value) {
    _customerId = value;
  }

  String get orderInstructions => _orderInstructions;

  set orderInstructions(String value) {
    _orderInstructions = value;
  }

  String get orderTimestamp => _orderTimestamp;

  set orderTimestamp(String value) {
    _orderTimestamp = value;
  }

  String get orderTime => _orderTime;

  set orderTime(String value) {
    _orderTime = value;
  }

  String get orderDate => _orderDate;

  set orderDate(String value) {
    _orderDate = value;
  }

  String get orderDuration => _orderDuration;

  set orderDuration(String value) {
    _orderDuration = value;
  }

  String get orderStatus => _orderStatus;

  set orderStatus(String value) {
    _orderStatus = value;
  }

  String get orderNumberOfItems => _orderNumberOfItems;

  set orderNumberOfItems(String value) {
    _orderNumberOfItems = value;
  }

  String get orderTotalAmount => _orderTotalAmount;

  set orderTotalAmount(String value) {
    _orderTotalAmount = value;
  }

  String get orderDiscount => _orderDiscount;

  set orderDiscount(String value) {
    _orderDiscount = value;
  }

  String get orderTax => _orderTax;

  set orderTax(String value) {
    _orderTax = value;
  }

  String get orderAmount => _orderAmount;

  set orderAmount(String value) {
    _orderAmount = value;
  }

  String get orderNumber => _orderNumber;

  set orderNumber(String value) {
    _orderNumber = value;
  }

  String get orderId => _orderId;

  set orderId(String value) {
    _orderId = value;
  }
}