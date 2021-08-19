import 'package:firebase_database/firebase_database.dart';

class UserDataFromSnapshot{
  String? id,email,name,phone;
  UserDataFromSnapshot({this.id,this.email,this.name,this.phone});
  UserDataFromSnapshot.fromSnapshot(DataSnapshot dataSnapshot){
    id=dataSnapshot.key;
    email=dataSnapshot.value["email"];
    name=dataSnapshot.value["name"];
    phone=dataSnapshot.value["phone"];
  }
}