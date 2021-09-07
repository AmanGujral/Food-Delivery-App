class Restaurant {
  String _id; // Restaurant Id
  String _name; // Restaurant Name
  String _imageUrl; // Restaurant Image Url
  String _address; // Restaurant Address
  String _rating; // Restaurant Overall Rating
  String _currentStatus; // Restaurant Current Status - Open, Closed

  //<-- @currentStatus can only have one of these values -->
  static const String RESTAURANT_STATUS_OPEN = "Open";
  static const String RESTAURANT_STATUS_CLOSED = "Closed";

  //<---------------------------------------------------->

  Restaurant({
    String id,
    String name,
    String imageUrl,
    String address,
    String rating,
    String currentStatus,
  }) {
    this._id = id ?? '';
    this._name = name ?? '';
    this._imageUrl = imageUrl ?? '';
    this._address = address ?? '';
    this._rating = rating ?? '';
    this._currentStatus = currentStatus ?? '';
  }

  Map<String, dynamic> toMap(Restaurant restaurant) {
    Map<String, dynamic> map = {
      "id": restaurant.id ?? '',
      "name": restaurant.name ?? '',
      "imageUrl": restaurant.imageUrl ?? '',
      "address": restaurant.address ?? '',
      "rating": restaurant.rating ?? '',
      "currentStatus": restaurant.currentStatus ?? '',
    };
    return map;
  }

  Restaurant fromMap(Map<String, dynamic> map) {
    return new Restaurant(
      id: map["id"] ?? '',
      name: map["name"] ?? '',
      imageUrl: map["imageUrl"] ?? '',
      address: map["address"] ?? '',
      rating: map["rating"] ?? '',
      currentStatus: map["currentStatus"] ?? '',
    );
  }

  static List<Restaurant> get  allRestaurantsList => _allRestaurantsList;

  static List<Restaurant> _allRestaurantsList = [];

  static Future<void> setAllRestaurantsList({List<Restaurant> allRestaurants}) {
    allRestaurantsList.clear();
    if (allRestaurants != null) {
      _allRestaurantsList = allRestaurants;
    }
    return null;
  }

  String get currentStatus => _currentStatus;

  set currentStatus(String value) {
    _currentStatus = value;
  }

  String get rating => _rating;

  set rating(String value) {
    _rating = value;
  }

  String get address => _address;

  set address(String value) {
    _address = value;
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
