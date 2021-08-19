import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/configs/providers/appDataProvider.dart';
import 'package:uber_clone/models/address.dart';
import 'package:uber_clone/models/placePredictions.dart';

class AddressDetails {
  static Future<void> getAddressDetails(
      PlacePredictions placePredictions, BuildContext context) async {
    Address _address = Address();
    _address.latitude = placePredictions.latitude!;
    _address.longitude = placePredictions.longitude!;
    _address.placeName = (placePredictions.type!.trim().length +
                placePredictions.road!.trim().length) !=
            0
        ? placePredictions.type! + ", " + placePredictions.road!
        : placePredictions.formatted!;
    Provider.of<AppData>(context, listen: false)
        .updateDropOffLocation(_address);
  }
}
