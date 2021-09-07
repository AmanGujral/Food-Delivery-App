
class User {
  String _id;                         // Customer Id
  String _firstName;                  // Customer First name
  String _lastName;                   // Customer Last name
  String _email;                      // Customer Email
  String _phone;                      // Customer Phone number
  String _savedAddress;               // Customer Address or Delivery Address
  String _imageUrl;                   // Customer Image Url

  static User _instance;              // Static instance of this class so that only one copy of this class is used throughout the app

  User({
    String id,
    String firstName,
    String lastName,
    String email,
    String phone,
    String savedAddress,
    String imageUrl,})
  {
    this._id = id ?? '';
    this._firstName = _firstName ?? '';
    this._lastName = lastName ?? '';
    this._email = email ?? '';
    this._phone = phone ?? '';
    this._savedAddress = savedAddress ?? '';
    this._imageUrl = imageUrl ?? '';
  }

  User getInstance() {
    if(_instance != null){
      // When user is already using the app
      return _instance;
    }
    else{
      // When user opens the app
      return new User();
    }
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": _id ?? '',
      "firstName": _firstName ?? '',
      "lastName": _lastName ?? '',
      "email": _email ?? '',
      "phone": _phone ?? '',
      "savedAddress": _savedAddress ?? '',
      "imageUrl": _imageUrl ?? '',
    };
    return map;
  }

  fromMap(Map<String, dynamic> map) {
    this._id = map["id"] ?? '';
    this._firstName = map["firstName"] ?? '';
    this._lastName = map["lastName"] ?? '';
    this._email = map["email"] ?? '';
    this._phone = map["phone"] ?? '';
    this._savedAddress = map["savedAddress"] ?? '';
    this._imageUrl = map["imageUrl"] ?? '';
  }

  String get imageUrl => _imageUrl;

  set imageUrl(String value) {
    _imageUrl = value;
  }


  String get savedAddress => _savedAddress;

  set savedAddress(String value) {
    _savedAddress = value;
  }

  String get phone => _phone;

  set phone(String value) {
    _phone = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get lastName => _lastName;

  set lastName(String value) {
    _lastName = value;
  }

  String get firstName => _firstName;

  set firstName(String value) {
    _firstName = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}