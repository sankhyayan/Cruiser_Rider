import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/configs/providers/appDataProvider.dart';
import 'package:uber_clone/models/nearbyAvailableDrivers.dart';

class GeoFireAssistant {
  ///variables
  static List<NearbyAvailableDrivers> nearbyAvailableDriversList = [];
  static BitmapDescriptor nearbyIcon = BitmapDescriptor.defaultMarker;

  ///deleting only required index drivers
  static void removeDriverFromList(String key) {
    ///searching index where element's key=our sent key
    int index =
        nearbyAvailableDriversList.indexWhere((element) => element.key == key);
    if(nearbyAvailableDriversList.length!=0){
      ///deleting only required index value
      nearbyAvailableDriversList.removeAt(index);
    }
  }

  ///live location update function
  static updateDriverNearByLocation(NearbyAvailableDrivers driver) {
    int index = nearbyAvailableDriversList
        .indexWhere((element) => element.key == driver.key);
    nearbyAvailableDriversList[index].latitude = driver.latitude;
    nearbyAvailableDriversList[index].longitude = driver.longitude;
  }

  ///random number generator for rotation
  static double createRandomNumber(int num) {
    var random = Random();
    int radNumber = random.nextInt(num);
    return radNumber.toDouble();
  }

  ///updating drivers marker set
  static void updateAvailableDriversOnMap(BuildContext context) {
    ///clearing markers set in provider
    Provider.of<AppData>(context, listen: false).clearMarkersSet();
    Set<Marker> driverMarkers = Set<Marker>(); //driver marker set
    ///adding driver markers to set
    if (nearbyAvailableDriversList.length != 0) {
      for (NearbyAvailableDrivers driver
          in GeoFireAssistant.nearbyAvailableDriversList) {
        LatLng driverAvailablePosition =
            LatLng(driver.latitude!, driver.longitude!);
        Marker marker = Marker(
          markerId: MarkerId("driver${driver.key}"),
          position: driverAvailablePosition,
          icon: nearbyIcon,
          rotation: GeoFireAssistant.createRandomNumber(360),
        );
        driverMarkers.add(marker);
      }
    }

    ///updating markers set in provider
    Provider.of<AppData>(context, listen: false).updateMarkerSet(driverMarkers);
  }

  ///car icon marker creator
  static void createIconMarker(BuildContext context) {
    if (nearbyIcon == BitmapDescriptor.defaultMarker) {
      ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(context, size: Size(2, 2));
      BitmapDescriptor.fromAssetImage(
              imageConfiguration, "assets/images/car-android.png")
          .then((value) => nearbyIcon = value);
    }
  }
}
