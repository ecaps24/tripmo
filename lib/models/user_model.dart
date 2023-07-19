import 'package:firebase_database/firebase_database.dart';

class User {
  //create properties for name, email, phone, address
  String? name;
  String? email;
  String? phone;
  String? address;

  //create constructor
  User({
    this.name,
    this.email,
    this.phone,
    this.address,
  });

  //create a data snapshot method to convert data from firebase to user model
  User.fromSnapshot(DataSnapshot snapshot) {
    //get data from snapshot
    name = (snapshot.value as dynamic)['name'];
    email = (snapshot.value as dynamic)['email'];
    phone = (snapshot.value as dynamic)['phone'];
    address = (snapshot.value as dynamic)['address'];
  }
}
