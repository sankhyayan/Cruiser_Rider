import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/configs/locationRequests/assistantMethods.dart';
import 'package:uber_clone/configs/locationRequests/userGeoLocator.dart';
import 'package:uber_clone/configs/providers/appDataProvider.dart';
import 'package:uber_clone/models/directionDetails.dart';

class DriverTimeTracking {
  static Future<void> update(BuildContext context) async {
    ///designated driver's location
    LatLng designatedLocation = LatLng(0, 0);

    ///current driver latLng
    LatLng driverCurrentLatLng =
        Provider.of<AppData>(context, listen: false).driverCurrentLocation;
    if (Provider.of<AppData>(context, listen: false).tripStatus != "arrived") {
      ///current rider[user] latLng
      designatedLocation = await UserGeoLocation.locatePosition()
          .then((position) => LatLng(position.latitude, position.longitude));
    } else {
      ///designated drop Off Location
      designatedLocation = LatLng(
          Provider.of<AppData>(context, listen: false)
              .dropOffLocation
              .latitude!,
          Provider.of<AppData>(context, listen: false)
              .dropOffLocation
              .longitude!);
    }

    ///getting driver to rider direction details in realtime
    DirectionDetails? driverToRiderDirectionDetails =
        await AssistantMethods.obtainPlaceDirectionsDetails(
            driverCurrentLatLng, designatedLocation);
    if (driverToRiderDirectionDetails != null) {
      ///updating trip duration
      Provider.of<AppData>(context, listen: false)
          .updateTripTimeStatus(driverToRiderDirectionDetails.durationText!);
    }
  }
}
