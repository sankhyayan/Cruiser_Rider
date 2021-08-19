import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/configs/providers/appDataProvider.dart';
import 'package:uber_clone/database/RideRequestMethods/cancelRideRequest.dart';

class CancelRide extends StatelessWidget {
  final double defaultSize;
  CancelRide({required this.defaultSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        alignment: Alignment.bottomCenter,
        heightFactor: defaultSize * 1.175,
        child: RaisedButton(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          color: Colors.black,
          onPressed: () async {
            Provider.of<AppData>(context, listen: false).clearRideRequest(context);
          },
          child: Padding(
            padding: EdgeInsets.all(defaultSize * .8),
            child: Icon(
              Icons.close,
              size: defaultSize * 4,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
