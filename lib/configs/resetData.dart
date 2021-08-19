import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/configs/providers/appDataProvider.dart';
import 'package:uber_clone/database/RideRequestMethods/cancelRideRequest.dart';
import 'package:uber_clone/models/address.dart';
import 'package:uber_clone/models/directionDetails.dart';

class ResetData {
  static void resetData(BuildContext context) async{
    ///resetting home address
    Provider.of<AppData>(context, listen: false)
        .updatePickupLocation(Address(placeName: "Add Home"));

    ///resetting drop address
    Provider.of<AppData>(context, listen: false)
        .updateDropOffLocation(Address(placeName: "Add Drop"));

    ///clearing polyline set
    Provider.of<AppData>(context, listen: false).clearPolyLineSet();

    ///clearing markers set
    Provider.of<AppData>(context, listen: false).clearMarkersSet();

    ///clearing circles set
    Provider.of<AppData>(context, listen: false).clearCirclesSet();

    ///resetting response
    Provider.of<AppData>(context, listen: false).updateResponse("");

    ///resetting animateMap
    Provider.of<AppData>(context, listen: false).clearAnimateMap();

    ///resetting directionDetails
    Provider.of<AppData>(context, listen: false).updateDirectionDetails(
      DirectionDetails(
          durationValue: 0,
          distanceValue: 0,
          distanceText: "",
          durationText: ""),
    );
    ///resetting ride request
    Provider.of<AppData>(context,listen: false).clearRideRequest(context);

  }
}
