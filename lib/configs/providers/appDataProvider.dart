import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_clone/database/RideRequestMethods/cancelRideRequest.dart';
import 'package:uber_clone/models/address.dart';
import 'package:uber_clone/models/directionDetails.dart';
import 'package:uber_clone/models/driverDataFromSnapshot.dart';
import 'package:uber_clone/models/userDataFromSnapshot.dart';

class AppData extends ChangeNotifier {
  Address pickupLocation = Address(placeName: "Add Home");
  Address dropOffLocation = Address(placeName: "Add Drop");
  Set<Marker> mapMarkers = {};
  Set<Circle> mapCircles = {};
  Set<Polyline> polylineSet = {};
  UserDataFromSnapshot currentUserInfo =
      UserDataFromSnapshot(id: "", email: "", name: "", phone: "");
  DriverDataFromSnapshot currentDriverInfo =
      DriverDataFromSnapshot(name: "", carDetails: "", phone: "");
  DirectionDetails directionDetails = DirectionDetails(
      durationValue: 0, distanceValue: 0, distanceText: "", durationText: "");
  bool animateMap = false;
  String response = "";
  bool rideRequest = false;
  bool requestedRideAcceptedStatus = false;
  LatLngBounds latLngBounds =
      LatLngBounds(southwest: LatLng(0.0, 0.0), northeast: LatLng(0.0, 0.0));
  void updatePickupLocation(Address _pickupAddress) {
    pickupLocation = _pickupAddress;
    notifyListeners();
  }

  void updateDropOffLocation(Address _dropOffAddress) {
    dropOffLocation = _dropOffAddress;
    notifyListeners();
  }

  void updatePolyLineSet(Set<Polyline> _polylineSet) {
    polylineSet = _polylineSet;
    notifyListeners();
  }

  void updateMarkerSet(Set<Marker> _mapMarkers) {
    mapMarkers = _mapMarkers;
    notifyListeners();
  }

  void updateCircleSet(Set<Circle> _mapCircles) {
    mapCircles = _mapCircles;
    notifyListeners();
  }

  void updateLatLngBounds(LatLngBounds _latLngBounds) {
    latLngBounds = _latLngBounds;
    notifyListeners();
  }

  void updateResponse(String _response) {
    response = _response;
    notifyListeners();
  }

  void animateGoogleCamera() {
    animateMap = true;
    notifyListeners();
  }

  void updateDirectionDetails(DirectionDetails _directionDetails) {
    directionDetails = _directionDetails;
    notifyListeners();
  }

  void updateRideRequest() {
    rideRequest = true;
    notifyListeners();
  }

  void updateRideRequestStatus() {
    requestedRideAcceptedStatus = true;
    rideRequest = false;
    notifyListeners();
  }

  void getCurrentUserInfo(UserDataFromSnapshot _currentUserInfo) {
    currentUserInfo = _currentUserInfo;
    notifyListeners();
  }

  void getCurrentDriverInfo(DriverDataFromSnapshot _currentDriverInfo) {
    currentDriverInfo = _currentDriverInfo;
    notifyListeners();
  }

  void clearPolyLineSet() {
    polylineSet.clear();
    notifyListeners();
  }

  void clearMarkersSet() {
    mapMarkers.clear();
    notifyListeners();
  }

  void clearCirclesSet() {
    mapCircles.clear();
    notifyListeners();
  }

  void clearAnimateMap() {
    animateMap = false;
    notifyListeners();
  }

  void clearRideRequest(BuildContext context) async {
    await CancelRideRequest.removeRideRequest(context);
    rideRequest = false;
    notifyListeners();
  }

  void clearRideRequestStatus(BuildContext context) async {
    requestedRideAcceptedStatus = false;
    notifyListeners();
  }
}
