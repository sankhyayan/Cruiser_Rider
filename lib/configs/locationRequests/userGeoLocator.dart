import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserGeoLocation {
  static Future<Position> locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    return position;
  }

  static Future<CameraPosition> getCamPosition() async {
    Position currentPosition = await UserGeoLocation.locatePosition();
    LatLng _latLng =
        LatLng(currentPosition.latitude, currentPosition.longitude);
    CameraPosition _cameraPosition = CameraPosition(target: _latLng, zoom: 14);
    return _cameraPosition;
  }
}
