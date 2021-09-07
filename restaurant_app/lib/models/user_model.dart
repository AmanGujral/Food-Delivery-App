
class UserModel {
  String _id;                         // Restaurant Id
  String _name;                       // Restaurant Name
  String _email;                      // Restaurant Email
  String _phone;                      // Restaurant Phone number
  String _address;                    // Restaurant Address or Delivery Address
  String _imageUrl;                   // Restaurant Image Url
  String _currentStatus;              // Restaurant Current status - Open, Closed
  String _rating;                     // Restaurant Overall Rating
  String _numberOfRatings;            // Total number of ratings for the restaurant

  static UserModel _instance;              // Static instance of this class so that only one copy of this class is used throughout the app

  //<-- @currentStatus can only have one of these values -->
  static const String RESTAURANT_STATUS_OPEN = "Open";
  static const String RESTAURANT_STATUS_CLOSED = "Closed";
  //<---------------------------------------------------->

  UserModel({
    String id,
    String name,
    String email,
    String phone,
    String address,
    String imageUrl,
    String currentStatus,
    String rating,
    String numberOfRatings,})
  {
    this._id = id ?? '';
    this._name = name ?? '';
    this._email = email ?? '';
    this._phone = phone ?? '';
    this._address = address ?? '';
    this._imageUrl = imageUrl ?? '';
    this._currentStatus = currentStatus ?? '';
    this._rating = rating ?? '';
    this._numberOfRatings = numberOfRatings ?? '';
  }

  UserModel getInstance() {
    if(_instance == null)
      _instance = new UserModel();

    return _instance;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": _id ?? '',
      "firstName": _name ?? '',
      "email": _email ?? '',
      "phone": _phone ?? '',
      "address": _address ?? '',
      "imageUrl": _imageUrl ?? '',
      "currentStatus": _currentStatus ?? '',
      "rating": _rating ?? '',
      "numberOfRatings": _numberOfRatings ?? '',
    };
    return map;
  }

  void fromMap(Map<String, dynamic> map) {
    this._id = map["id"] ?? '';
    this._name = map["firstName"] ?? '';
    this._email = map["email"] ?? '';
    this._phone = map["phone"] ?? '';
    this._address = map["address"] ?? '';
    this._imageUrl = map["imageUrl"] ?? '';
    this._currentStatus = map["currentStatus"] ?? '';
    this._rating = map["rating"] ?? '';
    this._numberOfRatings = map["numberOfRatings"] ?? '';
  }

  String get imageUrl => _imageUrl;

  set imageUrl(String value) {
    _imageUrl = value;
  }

  String get phone => _phone;

  set phone(String value) {
    _phone = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get numberOfRatings => _numberOfRatings;

  set numberOfRatings(String value) {
    _numberOfRatings = value;
  }

  String get rating => _rating;

  set rating(String value) {
    _rating = value;
  }

  String get currentStatus => _currentStatus;

  set currentStatus(String value) {
    _currentStatus = value;
  }

  String get address => _address;

  set address(String value) {
    _address = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}