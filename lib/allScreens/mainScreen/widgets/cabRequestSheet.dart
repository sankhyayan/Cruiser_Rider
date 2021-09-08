import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/configs/GeofireAvailableDriverMethods/geoFireNearestAvailableDriver.dart';
import 'package:uber_clone/configs/locationRequests/assistantMethods.dart';
import 'package:uber_clone/configs/providers/appDataProvider.dart';

class CabRequestBottomSheet extends StatelessWidget {
  final double defaultSize;
  const CabRequestBottomSheet({required this.defaultSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: defaultSize * 26,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(defaultSize * 1.8),
          topRight: Radius.circular(defaultSize * 1.8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: defaultSize * 1.2,
            spreadRadius: defaultSize * .03,
            offset: Offset(defaultSize * .02, defaultSize * .02),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: defaultSize * 1.7),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultSize * 1.5),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(defaultSize * 1.8),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(.5),
                        spreadRadius: defaultSize * .008,
                        blurRadius: defaultSize * 1.9,
                        offset: Offset(0.0, 12))
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultSize * 1.6,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/taxi.png",
                        height: defaultSize * 7,
                        width: defaultSize * 8,
                      ),
                      SizedBox(
                        width: defaultSize * 1.6,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Car",
                            style: TextStyle(
                                fontSize: defaultSize * 1.8,
                                fontFamily: "Brand Bold"),
                          ),
                          Text(
                            Provider.of<AppData>(context)
                                    .directionDetails
                                    .distanceValue!
                                    .truncate()
                                    .toString() +
                                "Km",
                            style: TextStyle(
                                fontSize: defaultSize * 1.8,
                                color: Colors.grey[600],
                                fontFamily: "Brand Bold"),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Text(
                        "${AssistantMethods.calculateFares(Provider.of<AppData>(context).directionDetails)}",
                        style: TextStyle(
                          fontFamily: "Brand Bold",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: defaultSize * 2,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultSize * 1.9),
              child: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.moneyCheckAlt,
                    size: defaultSize * 2,
                    color: Colors.black54,
                  ),
                  SizedBox(
                    width: defaultSize * 1.8,
                  ),
                  Text(
                    "Cash",
                    style: TextStyle(fontFamily: "Brand Bold"),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: Colors.black,
                    size: defaultSize * 1.8,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: defaultSize * 4,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultSize * 1.6),
              child: RaisedButton(
                padding: EdgeInsets.symmetric(
                    vertical: defaultSize * 1.4, horizontal: defaultSize * 1.5),
                elevation: defaultSize * 1.5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(defaultSize * 2),
                    side: BorderSide.none),
                color: Colors.black,
                onPressed: () async {
                  Provider.of<AppData>(context, listen: false)
                      .updateRideRequest();
                  NearestAvailableDriver.searchNearestDriver(
                      context, defaultSize);
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    defaultSize * .5,
                    0.0,
                    defaultSize * .5,
                    0.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Request",
                        style: TextStyle(
                          fontSize: defaultSize * 2,
                          fontFamily: "Brand Bold",
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        FontAwesomeIcons.taxi,
                        color: Colors.white,
                        size: defaultSize * 1.8,
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
