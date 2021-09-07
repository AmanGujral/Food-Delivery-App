
class AddOn {
  String _id;                         // Add On Id
  String _name;                       // Add On Name
  String _quantity;                   // Add On Quantity (If applicable)
  String _price;                      // Add On Price (If applicable)

  AddOn({
    String id,
    String name,
    String quantity,
    String price,})
  {
    this._id = id ?? '';
    this._name = name ?? '';
    this._quantity = quantity ?? '';
    this._price = price ?? '';
  }

  Map<String, dynamic> toMap(AddOn addOn) {
    Map<String, dynamic> map = {
      "id": addOn.id ?? '',
      "name": addOn.name ?? '',
      "quantity": addOn.quantity ?? '',
      "price": addOn.price ?? '',
    };
    return map;
  }

  AddOn fromMap(Map<String, dynamic> map) {
    return new AddOn(
      id: map["id"] ?? '',
      name: map["name"] ?? '',
      quantity: map["quantity"] ?? '',
      price: map["price"] ?? '',
    );
  }


  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get name => _name;

  String get price => _price;

  set price(String value) {
    _price = value;
  }

  String get quantity => _quantity;

  set quantity(String value) {
    _quantity = value;
  }

  set name(String value) {
    _name = value;
  }
}