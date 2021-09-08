import 'package:flutter/cupertino.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uber_clone/configs/GeofireAvailableDriverMethods/geoFireAssistance.dart';
import 'package:uber_clone/configs/locationRequests/userGeoLocator.dart';
import 'package:uber_clone/models/nearbyAvailableDrivers.dart';

class GeoFireListener {
  static bool nearByAvailableDriversLoaded = false;

  ///function to retrieve nearby drivers
  static Future<void> initGeoFireListener(BuildContext context) async {
    ///creating car icon  marker
    GeoFireAssistant.createIconMarker(context);
    ///getting current position
    Position currentPosition = await UserGeoLocation.locatePosition();

    ///initializing live data location and setting location in rdb
    await Geofire.initialize("availableDrivers");

    ///querying nearby area of predefined radius with current position
    Geofire.queryAtLocation(
            currentPosition.latitude, currentPosition.longitude, 10)!
        .listen((map) async {
      if (map != null) {
        var callBack = map['callBack'];
        switch (callBack) {

          ///drivers coming online or available in defined radius area
          case Geofire.onKeyEntered:
            NearbyAvailableDrivers nearbyAvailableDrivers =
                NearbyAvailableDrivers();
            nearbyAvailableDrivers.key = map['key'];
            nearbyAvailableDrivers.latitude = map['latitude'];
            nearbyAvailableDrivers.longitude = map['longitude'];
            GeoFireAssistant.nearbyAvailableDriversList
                .add(nearbyAvailableDrivers);
            GeoFireAssistant.updateAvailableDriversOnMap(context);
            break;

          ///drivers becoming offline
          case Geofire.onKeyExited:
            GeoFireAssistant.removeDriverFromList(map['key']);
            GeoFireAssistant.updateAvailableDriversOnMap(context);
            break;

          ///when drivers move around the map{Location updater}
          case Geofire.onKeyMoved:
            NearbyAvailableDrivers nearbyAvailableDrivers =
                NearbyAvailableDrivers();
            nearbyAvailableDrivers.key = map['key'];
            nearbyAvailableDrivers.latitude = map['latitude'];
            nearbyAvailableDrivers.longitude = map['longitude'];
            GeoFireAssistant.updateDriverNearByLocation(nearbyAvailableDrivers);
            GeoFireAssistant.updateAvailableDriversOnMap(context);
            break;

          case Geofire.onGeoQueryReady:
            GeoFireAssistant.updateAvailableDriversOnMap(context);
            break;
        }
      }
    });
  }
}
