import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uber_clone/allOverAppWidgets/noAvailableDriverDialog.dart';
import 'package:uber_clone/configs/GeofireAvailableDriverMethods/geoFireAssistance.dart';
import 'package:uber_clone/configs/locationRequests/assistantMethods.dart';
import 'package:uber_clone/configs/locationRequests/userGeoLocator.dart';
import 'package:uber_clone/configs/notificationSender/nearestDriverDetails.dart';
import 'package:uber_clone/configs/resetData.dart';
import 'package:uber_clone/database/RideRequestMethods/saveRideRequests.dart';
import 'package:uber_clone/models/nearbyAvailableDrivers.dart';

///accessing nearest available driver
class NearestAvailableDriver {
  static late NearbyAvailableDrivers nearestDriver;
  static Future<void> searchNearestDriver(
      BuildContext context, double defaultSize) async {
    ///if no driver available then reset data
    if (GeoFireAssistant.nearbyAvailableDriversList.length == 0) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) =>
              NoAvailableDriverDialog(defaultSize: defaultSize));

      ///resetting data
      await ResetData.resetData(context);

      ///accessing user current location
      await AssistantMethods.searchCoordinates(
          await UserGeoLocation.locatePosition(), context);
    } else {
      await SaveRideRequest.saveRideRequest(context);
      nearestDriver = GeoFireAssistant.nearbyAvailableDriversList[0];
      GeoFireAssistant.nearbyAvailableDriversList.removeAt(0);

      ///gets the details of nearest driver and sends him/her a notification
      await NearestDriverDetails.nearestDriverDetails(
          nearestDriver, context, defaultSize);
    }
  }
}
