import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/allOverAppWidgets/progressDialog.dart';
import 'package:uber_clone/configs/locationRequests/assistantMethods.dart';
import 'package:uber_clone/configs/providers/appDataProvider.dart';
import 'package:uber_clone/models/directionDetails.dart';

class PlaceDirection {
  static Future<void> getPlaceDirection(
      BuildContext context, double defaultSize) async {
    ///required values
    List<LatLng> _pLineCoordinates = [];
    Set<Polyline> _polylineSet = {};
    Set<Marker> _mapMarkers = {};
    Set<Circle> _mapCircles = {};

    ///getting location details
    var _pickupLocation =
        Provider.of<AppData>(context, listen: false).pickupLocation;
    var _dropOffLocation =
        Provider.of<AppData>(context, listen: false).dropOffLocation;

    ///segregating location details
    var _pickupLatLng =
        LatLng(_pickupLocation.latitude!, _pickupLocation.longitude!);
    var _dropOffLatLng =
        LatLng(_dropOffLocation.latitude!, _dropOffLocation.longitude!);

    ///progress dialog bar
    showDialog(
      context: context,
      builder: (context) =>
          ProgressDialog(defaultSize: defaultSize, message: "Please wait..."),
    );

    ///getting direction details and encoded path
    DirectionDetails? _directionDetails =
        await AssistantMethods.obtainPlaceDirectionsDetails(
            _pickupLatLng, _dropOffLatLng);

    ///updating direction details provider
    Provider.of<AppData>(context, listen: false)
        .updateDirectionDetails(_directionDetails!);

    ///declaring poly points
    PolylinePoints _polylinePoints = PolylinePoints();

    ///decoding encoded path and getting list of latlng
    List<PointLatLng> _decodePolylinePointsResult =
        _polylinePoints.decodePolyline(_directionDetails.encodedPoints!);

    ///clearing coordinates before inputting new path
    _pLineCoordinates.clear();

    ///adding new path coordinates to pline
    if (_decodePolylinePointsResult.isNotEmpty) {
      _decodePolylinePointsResult.forEach((PointLatLng _pointLatLng) {
        _pLineCoordinates
            .add(LatLng(_pointLatLng.latitude, _pointLatLng.longitude));
      });
    }

    ///declaring and creating a polyline
    Polyline _polyline = Polyline(
      polylineId: PolylineId("PolylineID"),
      color: Colors.black,
      jointType: JointType.round,
      points: _pLineCoordinates,
      width: (defaultSize.toInt() * .4).toInt(),
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      geodesic: true,
    );

    ///clearing polyline set before adding new polyline
    _polylineSet.clear();
    _polylineSet.add(_polyline);

    ///getting latlng bounds for the map
    LatLngBounds latLngBounds = LatLngBounds(
        southwest:
            LatLng(_directionDetails.minLat!, _directionDetails.minLong!),
        northeast:
            LatLng(_directionDetails.maxLat!, _directionDetails.maxLong!));

    ///updating polyline set in provider
    Provider.of<AppData>(context, listen: false)
        .updatePolyLineSet(_polylineSet);

    ///updating latlng bounds in provider
    Provider.of<AppData>(context, listen: false)
        .updateLatLngBounds(latLngBounds);

    ///updating animate checker in provider
    Provider.of<AppData>(context, listen: false).animateGoogleCamera();

    ///creating pick and drop markers
    Marker _pickupMarker = Marker(
      markerId: MarkerId("pickupID"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow:
          InfoWindow(title: _pickupLocation.placeName, snippet: "My Location"),
      position: _pickupLatLng,
    );
    Marker _dropOffMarker = Marker(
      markerId: MarkerId("dropOffID"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: InfoWindow(
          title: _dropOffLocation.placeName, snippet: "Drop Location"),
      position: _dropOffLatLng,
    );

    ///clearing marker set before adding new markers
    _mapMarkers.clear();
    _mapMarkers.add(_pickupMarker);
    _mapMarkers.add(_dropOffMarker);

    ///creating circle set for pick and drop
    Circle _pickupCircle = Circle(
        circleId: CircleId("pickupId"),
        fillColor: Colors.green,
        center: _pickupLatLng,
        radius: defaultSize * 1.2,
        strokeWidth: (defaultSize * .4).toInt(),
        strokeColor: Colors.greenAccent);
    Circle _dropOffCircle = Circle(
        circleId: CircleId("dropOffId"),
        fillColor: Colors.red,
        center: _dropOffLatLng,
        radius: defaultSize * 1.2,
        strokeWidth: (defaultSize * .4).toInt(),
        strokeColor: Colors.redAccent);

    ///clearing circle set before adding new circles
    _mapCircles.clear();
    _mapCircles.add(_pickupCircle);
    _mapCircles.add(_dropOffCircle);

    ///updating markers and circles set in provider
    Provider.of<AppData>(context, listen: false).updateMarkerSet(_mapMarkers);
    Provider.of<AppData>(context, listen: false).updateCircleSet(_mapCircles);
    Navigator.pop(context);
  }
}
