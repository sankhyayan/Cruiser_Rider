import 'package:flutter/material.dart';
import 'package:uber_clone/configs/locationRequests/assistantMethods.dart';
import 'package:uber_clone/configs/locationRequests/userGeoLocator.dart';
import 'package:uber_clone/configs/resetData.dart';
import 'package:uber_clone/configs/rideRequestAcceptedMethods/rideStatusListener.dart';

//todo use this method to listen to ride status
class CollectFareDialog extends StatelessWidget {
  final double defaultSize;
  final String paymentMethod;
  final String fareAmount;
  CollectFareDialog(
      {required this.defaultSize,
      required this.paymentMethod,
      required this.fareAmount});

  @override
  Widget build(BuildContext context) {
    ///tapped checker
    bool tapped = false;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultSize * 1.2),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(defaultSize * 1.2),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(defaultSize),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: defaultSize * 2.2,
            ),
            Text(
              paymentMethod.toUpperCase(),
              style: TextStyle(
                  fontSize: defaultSize * 2.5, fontFamily: "Brand Bold"),
            ),
            SizedBox(
              height: defaultSize * 2.2,
            ),
            Text(
              "$fareAmount Rs",
              style: TextStyle(
                  fontSize: defaultSize * 5.5, fontFamily: "Brand Bold"),
            ),
            SizedBox(
              height: defaultSize * 2.2,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultSize * 2),
              child: Text(
                "Trip Fare",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: defaultSize * 2, fontFamily: "Brand Bold"),
              ),
            ),
            SizedBox(
              height: defaultSize * 3,
            ),
            GestureDetector(
              onTap: () async {
                if (!tapped) {
                  tapped = true;
                  await RideStatusListener.stopStatusListener();
                  await ResetData.resetData(context);

                  ///accessing user current location
                  await AssistantMethods.searchCoordinates(
                      await UserGeoLocation.locatePosition(), context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              },
              child: Container(
                height: defaultSize * 7,
                decoration: BoxDecoration(
                  color: Colors.black,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: defaultSize * 4,
                      spreadRadius: defaultSize * .2,
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: defaultSize * 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "PAY",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: defaultSize * 2,
                        ),
                      ),
                      Icon(
                        Icons.work_outlined,
                        color: Colors.white,
                        size: defaultSize * 3.5,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
