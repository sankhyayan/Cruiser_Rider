import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/allScreens/mainScreen/widgets/collectFareDialog.dart';
import 'package:uber_clone/configs/providers/appDataProvider.dart';
import 'package:uber_clone/main.dart';

class RideStatusListener {
  static late StreamSubscription rideStatusListener;
  static Future<void> listen(BuildContext context, double defaultSize) async {
    rideStatusListener = rideRequestRef
        .child(Provider.of<AppData>(context, listen: false).currentUserInfo.id!)
        .child("status")
        .onValue
        .listen((status) async {
      if (status.snapshot.value != null) {
        if (status.snapshot.value.toString() == "trip_ended") {
          ///getting payment method
          String paymentMethod = await rideRequestRef
              .child(Provider.of<AppData>(context, listen: false)
                  .currentUserInfo
                  .id!)
              .child("payment_method")
              .get()
              .then((DataSnapshot? payment) {
            return payment!.value.toString();
          });

          ///getting fare Amount
          String fareAmount = await rideRequestRef
              .child(Provider.of<AppData>(context, listen: false)
                  .currentUserInfo
                  .id!)
              .child("fare")
              .get()
              .then((DataSnapshot? fareAmount) {
            return fareAmount!.value.toString();
          });

          ///displaying collect fare dialog
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => CollectFareDialog(
                defaultSize: defaultSize,
                paymentMethod: paymentMethod,
                fareAmount: fareAmount),
          );
        }
      }
    });
  }

  ///cancelling stream Subscription
  static Future<void> stopStatusListener() async {
    await rideStatusListener.cancel();
  }
}
