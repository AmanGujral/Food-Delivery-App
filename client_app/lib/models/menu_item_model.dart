

class MenuItem {
  String _id;                       // Menu Item Id
  String _name;                     // Menu Item Name
  String _imageUrl;                 // Menu Item Image Url
  String _price;                    // Menu Item Address
  String _description;              // Menu Item Description
  String _category;                 // Menu Item Category
  String _numberOfAddOns;           // Number of add-ons/sides with this item
  String _rating;                   // Menu Item Overall Rating
  String _currentStatus;            // Menu Item Current Status - Available, Sold Out

  //<-- @currentStatus can only have one of these values -->
  static const String MENU_ITEM_STATUS_AVAILABLE = "Available";
  static const String MENU_ITEM_STATUS_OLD_OUT = "Sold Out";
  //<---------------------------------------------------->

  MenuItem({
    String id,
    String name,
    String imageUrl,
    String price,
    String description,
    String category,
    String numberOfAddons,
    String rating,
    String currentStatus,})
  {
    this._id = id ?? '';
    this._name = name ?? '';
    this._imageUrl = imageUrl ?? '';
    this._price = price ?? '';
    this._description = description ?? '';
    this._category = category ?? '';
    this._numberOfAddOns = numberOfAddons ?? '';
    this._rating = rating ?? '';
    this._currentStatus = currentStatus ?? '';
  }

  Map<String, dynamic> toMap(MenuItem item) {
    Map<String, dynamic> map = {
      "id": item.id ?? '',
      "name": item.name ?? '',
      "imageUrl": item.imageUrl ?? '',
      "price": item.price ?? '',
      "description": item.description ?? '',
      "category": item.category ?? '',
      "numberOfAddOns": item.numberOfAddOns ?? '',
      "rating": item.rating ?? '',
      "currentStatus": item.currentStatus ?? '',
    };
    return map;
  }

  MenuItem fromMap(Map<String, dynamic> map) {
    return new MenuItem(
      id: map["id"] ?? '',
      name: map["name"] ?? '',
      imageUrl:  map["imageUrl"] ?? '',
      price: map["price"] ?? '',
      description: map["description"] ?? '',
      category: map["category"] ?? '',
      numberOfAddons: map["numberOfAddOns"] ?? '',
      rating: map["rating"] ?? '',
      currentStatus: map["currentStatus"] ?? '',
    );
  }

  String get currentStatus => _currentStatus;

  set currentStatus(String value) {
    _currentStatus = value;
  }

  String get rating => _rating;

  set rating(String value) {
    _rating = value;
  }

  String get numberOfAddOns => _numberOfAddOns;

  set numberOfAddOns(String value) {
    _numberOfAddOns = value;
  }

  String get category => _category;

  set category(String value) {
    _category = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get price => _price;

  set price(String value) {
    _price = value;
  }

  String get imageUrl => _imageUrl;

  set imageUrl(String value) {
    _imageUrl = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}