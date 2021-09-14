import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/configs/providers/appDataProvider.dart';
import 'package:uber_clone/configs/rideRequestAcceptedMethods/driverTimeTracking.dart';
import 'package:uber_clone/main.dart';
//todo: not tracking
class DriverLiveLocationTrack {
  static late StreamSubscription<Event> driverTrackSubscription;
  static Future<void> track(BuildContext context) async {
    int count = 0;

    ///listening to driver location changes
    driverTrackSubscription = rideRequestRef
        .child(Provider.of<AppData>(context, listen: false).currentUserInfo.id!)
        .child("driver_location")
        .onValue
        .listen((Event location) async {
      if (location.snapshot.value != null) {
        ///getting driver latitude and longitude
        double driverLat =
            double.parse(location.snapshot.value["latitude"].toString());
        double driverLng =
            double.parse(location.snapshot.value["longitude"].toString());

        ///Storing driver current latLng
        LatLng driverCurrentLatLng = LatLng(driverLat, driverLng);

        ///updating live driver location
        Provider.of<AppData>(context, listen: false)
            .updateCurrentDriverLocation(driverCurrentLatLng);

        ///getting trip status
        DataSnapshot? _tripStatus = await rideRequestRef
            .child(Provider.of<AppData>(context, listen: false)
                .currentUserInfo
                .id!)
            .child("status")
            .get();

        ///updating trip status
        Provider.of<AppData>(context, listen: false)
            .updateTripStatus(_tripStatus!.value.toString());
        count++;
        if (count == 20) {
          count = 0;
          await DriverTimeTracking.update(context);
        }
      }
    });
  }

  ///cancelling driver tracking
  static Future<void> removeTracking(BuildContext context) async {
    await driverTrackSubscription.cancel();

    ///resetting trip duration
    Provider.of<AppData>(context, listen: false).updateTripTimeStatus("");

    ///resetting trip status
    Provider.of<AppData>(context, listen: false).updateTripStatus("");
  }
}
