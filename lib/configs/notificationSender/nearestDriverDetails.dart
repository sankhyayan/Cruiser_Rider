import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/configs/GeofireAvailableDriverMethods/geoFireNearestAvailableDriver.dart';
import 'package:uber_clone/configs/apiConfigs.dart';
import 'package:uber_clone/configs/notificationSender/notifyNearestDriver.dart';
import 'package:uber_clone/configs/providers/appDataProvider.dart';
import 'package:uber_clone/main.dart';
import 'package:uber_clone/models/nearbyAvailableDrivers.dart';

class NearestDriverDetails {
  ///accessing driver details and performing the necessary steps
  static Future<void> nearestDriverDetails(NearbyAvailableDrivers driver,
      BuildContext context, double defaultSize) async {
    await driversRef
        .child(driver.key!)
        .child("driverState")
        .set(Provider.of<AppData>(context, listen: false).currentUserInfo.id!);
    await driversRef
        .child(driver.key!)
        .child("token")
        .once()
        .then((DataSnapshot snapshot) async {
      if (await snapshot.value != null) {
        await NotifyNearestDriver.notify(snapshot.value.toString(), context,
            Provider.of<AppData>(context, listen: false).currentUserInfo.id!);
      } else {
        return;
      }

      ///TIMER FUNCTION TO HANDLE RIDE REQUEST STATES
      Timer.periodic(Duration(seconds: 1), (timer) async {
        ///cancelled ride request state setter
        if (!Provider.of<AppData>(context, listen: false).rideRequest) {
          await driversRef
              .child(driver.key!)
              .child("driverState")
              .set("cancelled");
          driversRef.child(driver.key!).child("driverState").onDisconnect();
          driverRequestTimeout = 30;
          timer.cancel();
        }
        driverRequestTimeout = driverRequestTimeout - 1;
        print("Timeout: $driverRequestTimeout");

        ///listening to changes in driverState[accepted ride request state setter]
        driversRef
            .child(driver.key!)
            .child("driverState")
            .onValue
            .listen((state) {
          if (state.snapshot.value.toString() == "accepted") {
            driversRef.child(driver.key!).child("driverState").onDisconnect();
            driverRequestTimeout = 30;
            timer.cancel();
          }
        });

        ///checking timeout timer[timed out ride request state setter]
        if (driverRequestTimeout == 0) {
          ///setting driver state, disconnecting and reinitializing timeout timer
          await driversRef
              .child(driver.key!)
              .child("driverState")
              .set("timedOut");
          driversRef.child(driver.key!).child("driverState").onDisconnect();
          driverRequestTimeout = 30;

          ///cancelling timer subscription
          timer.cancel();

          ///getting next nearest driver
          await NearestAvailableDriver.searchNearestDriver(
              context, defaultSize);
        }
      });
    });
  }
}
