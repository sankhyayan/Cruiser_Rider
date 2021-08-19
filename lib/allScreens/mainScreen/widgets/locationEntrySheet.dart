import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/allScreens/searchScreen/searchScreen.dart';
import 'package:uber_clone/allWidgets/divider.dart';
import 'package:uber_clone/configs/constants.dart';
import 'package:uber_clone/configs/locationRequests/placeDirection.dart';
import 'package:uber_clone/configs/providers/appDataProvider.dart';

class LocationEntryBottomSheet extends StatelessWidget {
  final double defaultSize;
  LocationEntryBottomSheet({required this.defaultSize});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: defaultSize * 32,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(defaultSize * 1.8),
          topRight: Radius.circular(defaultSize * 1.8),
        ),
        boxShadow: [
          BoxShadow(
            color: Constants.kShadowColor,
            blurRadius: defaultSize * .8,
            spreadRadius: defaultSize * .03,
            offset: Offset(defaultSize * .02, defaultSize * .02),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: defaultSize * 2.4, vertical: defaultSize * 1.8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: defaultSize * 1.2),
            Expanded(
              child: Text(
                "Hi there, ",
                style: TextStyle(
                  fontSize: defaultSize * 1.8,
                ),
              ),
            ),
            SizedBox(
              height: defaultSize * .25,
            ),
            Expanded(
              flex: 2,
              child: Text(
                "Where to?",
                style: TextStyle(
                    fontSize: defaultSize * 2.5, fontFamily: "Brand-Bold"),
              ),
            ),
            SizedBox(height: defaultSize * 1.2),

            ///location bottom search container
            GestureDetector(
              onTap: () async {
                String response = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LocationSearchScreen()));
                if (response == "obtainDirection") {
                  Provider.of<AppData>(context,listen: false).updateResponse(response);
                  await PlaceDirection.getPlaceDirection(context, defaultSize);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(defaultSize * .5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: defaultSize * .3,
                      spreadRadius: defaultSize * .03,
                      offset: Offset(defaultSize * .02, defaultSize * .02),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(defaultSize * 1.2),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: defaultSize,
                      ),
                      Text(
                        "Search Drop Off",
                        style: TextStyle(fontSize: defaultSize * 1.75),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            ///home address
            SizedBox(
              height: defaultSize * 2.4,
            ),
            Row(
              children: [
                Icon(
                  Icons.home,
                  size: defaultSize * 2.7,
                ),
                SizedBox(
                  width: defaultSize * 2.1,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Provider.of<AppData>(context).pickupLocation.placeName!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: defaultSize * 1.75,
                          fontFamily: "Brand-Bold"),
                    ),
                    SizedBox(
                      height: defaultSize * .4,
                    ),
                    Text(
                      "Home Address",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: defaultSize * 1.5,
                          fontFamily: "Brand-Bold"),
                    ),
                  ],
                ),
              ],
            ),

            ///office address
            SizedBox(
              height: defaultSize * 1.5,
            ),
            DividerWidget(defaultSize: defaultSize),
            SizedBox(
              height: defaultSize * 1.5,
            ),
            Row(
              children: [
                Icon(
                  Icons.work,
                  size: defaultSize * 2.5,
                ),
                SizedBox(
                  width: defaultSize * 2.1,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add Work",
                      style: TextStyle(
                        fontSize: defaultSize * 1.75,
                        fontFamily: "Brand-Bold",
                      ),
                    ),
                    SizedBox(
                      height: defaultSize * .4,
                    ),
                    Text(
                      "Work Address",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: defaultSize * 1.5,
                          fontFamily: "Brand-Bold"),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
