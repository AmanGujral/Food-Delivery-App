
class UserModel {
  String _id;                         // Driver Id
  String _firstName;                  // Driver First name
  String _lastName;                   // Driver Last name
  String _email;                      // Driver Email
  String _phone;                      // Driver Phone number
  String _currentStatus;              // Driver current status - Online, Offline, Paused, Banned
  String _imageUrl;                   // Driver Image Url

  static UserModel _instance;              // Static instance of this class so that only one copy of this class is used throughout the app


  //<-- @currentStatus can only have one of these values -->
  static const String DRIVER_STATUS_ONLINE = "Online";
  static const String DRIVER_STATUS_OFFLINE = "Offline";
  static const String DRIVER_STATUS_PAUSED = "Paused";
  static const String DRIVER_STATUS_BANNED = "Banned";
  //<---------------------------------------------------->

  UserModel({
    String id,
    String firstName,
    String lastName,
    String email,
    String phone,
    String currentStatus,
    String imageUrl,})
  {
    this._id = id;
    this._firstName = _firstName;
    this._lastName = lastName;
    this._email = email;
    this._phone = phone;
    this._currentStatus = currentStatus;
    this._imageUrl = imageUrl;
  }

  UserModel getInstance() {
    if(_instance == null) {
      _instance = new UserModel();
    }
    return _instance;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": this._id ?? '',
      "firstName": this._firstName ?? '',
      "lastName": this._lastName ?? '',
      "email": this._email ?? '',
      "phone": this._phone ?? '',
      "currentStatus": this._currentStatus ?? '',
      "imageUrl": this._imageUrl ?? '',
    };
    return map;
  }

  fromMap(Map<String, dynamic> map) {
    this._id = map["id"];
    this._firstName = map["firstName"];
    this._lastName = map["lastName"];
    this._email = map["email"];
    this._phone = map["phone"];
    this._currentStatus = map["currentStatus"];
    this._imageUrl = map["imageUrl"];
  }

  String get imageUrl => _imageUrl;

  set imageUrl(String value) {
    _imageUrl = value;
  }


  String get currentStatus => _currentStatus;

  set currentStatus(String value) {
    _currentStatus = value;
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