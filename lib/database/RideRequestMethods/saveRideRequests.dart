import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/configs/providers/appDataProvider.dart';
import 'package:uber_clone/main.dart';
import 'package:uber_clone/models/address.dart';

class SaveRideRequest {
  static Future<void> saveRideRequest(BuildContext context) async {
    Address pickUp =
        Provider.of<AppData>(context, listen: false).pickupLocation;
    Address dropOff =
        Provider.of<AppData>(context, listen: false).dropOffLocation;
    Map pickUpLocationMap = {
      "latitude": pickUp.latitude.toString(),
      "longitude": pickUp.longitude.toString(),
    };
    Map dropOffLocationMap = {
      "latitude": dropOff.latitude.toString(),
      "longitude": dropOff.longitude.toString(),
    };
    Map rideInfoMap = {
      "driver_id": "waiting",
      "payment_method": "cash",
      "pickUp": pickUpLocationMap,
      "dropOff": dropOffLocationMap,
      "created_at": DateTime.now().toString(),
      "rider_name":
          Provider.of<AppData>(context, listen: false).currentUserInfo.name,
      "rider_phone":
          Provider.of<AppData>(context, listen: false).currentUserInfo.phone,
      "pickup_address": pickUp.placeName,
      "drop_off": dropOff.placeName,
    };

    await rideRequestRef
        .child(Provider.of<AppData>(context, listen: false).currentUserInfo.id!)
        .set(rideInfoMap);
  }
}
