import 'package:firebase_database/firebase_database.dart';

class DriverDataFromSnapshot{
  String? carDetails,name,phone;
  DriverDataFromSnapshot({this.carDetails,this.name,this.phone});
  DriverDataFromSnapshot.fromSnapshot(DataSnapshot dataSnapshot){
    carDetails=dataSnapshot.value["car_details"];
    name=dataSnapshot.value["driver_name"];
    phone=dataSnapshot.value["driver_phone"].toString();
  }
}