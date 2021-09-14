import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/configs/locationRequests/assistantMethods.dart';
import 'package:uber_clone/configs/providers/appDataProvider.dart';

class DriverInfoSheet extends StatelessWidget {
  final double defaultSize;
  DriverInfoSheet({required this.defaultSize});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: defaultSize * 30,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(defaultSize * 1.8),
          topRight: Radius.circular(defaultSize * 1.8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: defaultSize * .8,
            spreadRadius: defaultSize * .03,
            offset: Offset(defaultSize * .02, defaultSize * .02),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: defaultSize * 2, horizontal: defaultSize * 1.75),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //todo: live time track not working
                      Text(
                        "Arriving in " +
                            Provider.of<AppData>(context, listen: false)
                                .tripTimeStatus,
                        style: TextStyle(
                          fontSize: defaultSize * 2,
                          fontFamily: "Brand Bold",
                        ),
                      ),
                      Text(
                        "Rs. ${AssistantMethods.calculateFares(Provider.of<AppData>(context).directionDetails)}",
                        style: TextStyle(
                          fontFamily: "Brand Bold",
                          fontSize: defaultSize * 2,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: defaultSize * 3.2,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/pickicon.png",
                        height: defaultSize * 2,
                        width: defaultSize * 2,
                      ),
                      SizedBox(
                        width: defaultSize * 1.8,
                      ),
                      Expanded(
                        child: Text(
                          Provider.of<AppData>(context, listen: false)
                              .pickupLocation
                              .placeName!,
                          style: TextStyle(
                              fontSize: defaultSize * 1.8,
                              fontFamily: "Brand Bold"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: defaultSize * 1.8,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/desticon.png",
                        height: defaultSize * 2,
                        width: defaultSize * 2,
                      ),
                      SizedBox(
                        width: defaultSize * 1.8,
                      ),
                      Expanded(
                        child: Text(
                          Provider.of<AppData>(context, listen: false)
                              .dropOffLocation
                              .placeName!,
                          style: TextStyle(
                              fontSize: defaultSize * 1.8,
                              fontFamily: "Brand Bold"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: defaultSize * 2,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: defaultSize * 2,
                          backgroundColor: Colors.black,
                          child: Icon(
                            Icons.face,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: defaultSize * 1.5,
                        ),
                        Text(
                          Provider.of<AppData>(context, listen: false)
                              .currentDriverInfo
                              .name!,
                          maxLines: 1,
                          softWrap: true,
                          style: TextStyle(
                            fontSize: defaultSize * 2,
                            fontFamily: "Brand Bold",
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Text(
                          "5★",
                          style: TextStyle(
                            fontSize: defaultSize * 2,
                            fontFamily: "Brand Bold",
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: defaultSize * 1.5,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        SizedBox(
                          width: defaultSize * .3,
                        ),
                        Icon(
                          FontAwesomeIcons.car,
                          size: defaultSize * 3.6,
                        ),
                        SizedBox(
                          width: defaultSize * 1.5,
                        ),
                        Text(
                          Provider.of<AppData>(context, listen: false)
                                      .currentDriverInfo
                                      .carDetails !=
                                  ""
                              ? Provider.of<AppData>(context, listen: false)
                                      .currentDriverInfo
                                      .carDetails!
                                      .substring(0, 24) +
                                  "..."
                              : "",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: defaultSize * 2,
                            fontFamily: "Brand Bold",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: defaultSize * 15,
              ),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    spreadRadius: defaultSize * .25,
                    blurRadius: defaultSize * 5,
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: defaultSize),
                    child: Icon(
                      Icons.call,
                      color: Colors.white,
                      size: defaultSize * 5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
