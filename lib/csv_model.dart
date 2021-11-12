import 'dart:typed_data';

class Person {
  int _id;
  String _name, _address, _email, _phone;
  Uint8List _photo;
  Person(this._name, this._address, this._email, this._phone, this._photo);
  Person.id(this._id, this._name, this._address, this._email, this._phone, this._photo);

  int get id {
    return _id;
  }

  String get name {
    return _name;
  }

  String get address {
    return _address;
  }

  String get email {
    return _email;
  }

  String get phone {
    return _phone;
  }

  Uint8List get photo {
    return _photo;
  }

  set name(String newname) {
    this._name = newname;
  }

  set address(String newaddress) {
    this._address = newaddress;
  }

  set email(String newemail) {
    this._email = newemail;
  }

  set phone(String newphone) {
    this._phone = newphone;
  }

  set photo(Uint8List newphoto) {
    this._photo = newphoto;
  }

  Map<String, dynamic> toMap() {
    return {'name': _name, 'address': _address, 'email': _email, 'phone': _phone, 'photo': _photo};
  }

  Person.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._address = map['address'];
    this._email = map['email'];
    this._phone = map['phone'];
    this._photo = map['photo'];
  }
}
