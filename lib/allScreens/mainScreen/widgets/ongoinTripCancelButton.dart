import 'package:flutter/material.dart';
import 'package:uber_clone/configs/locationRequests/assistantMethods.dart';
import 'package:uber_clone/configs/locationRequests/userGeoLocator.dart';
import 'package:uber_clone/configs/resetData.dart';

class OngoingTripCancelButton extends StatelessWidget {
  final double defaultSize;
  OngoingTripCancelButton({required this.defaultSize});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await ResetData.resetData(context);

        ///accessing user current location
        await AssistantMethods.searchCoordinates(
            await UserGeoLocation.locatePosition(), context);
      },
      child: Container(
        height: defaultSize*9,
        width: defaultSize*5,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(right: defaultSize*.5),
          child: Icon(
            Icons.close,
            color: Colors.white,
            size: defaultSize * 4.5,
          ),
        ),
      ),
    );
  }
}
