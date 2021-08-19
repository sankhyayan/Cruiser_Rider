import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/allScreens/searchScreen/widgets/predictionTile.dart';
import 'package:uber_clone/configs/providers/appDataProvider.dart';
import 'package:uber_clone/configs/searchFunctions/locationSuggester.dart';
import 'package:uber_clone/configs/sizeConfig.dart';
import 'package:uber_clone/models/placePredictions.dart';

class LocationSearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<LocationSearchScreen> {
  TextEditingController _pickupTextEditingController = TextEditingController();
  TextEditingController _dropOffTextEditingController = TextEditingController();
  List<PlacePredictions> placePredictionList = [];
  @override
  Widget build(BuildContext context) {
    String _placeAddress =
        Provider.of<AppData>(context).pickupLocation.placeName ?? "";
    _pickupTextEditingController.text = _placeAddress;
    SizeConfig().init(context);
    final double defaultSize = SizeConfig.defaultSize;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            ///tile for setting pickup/drop off location
            Container(
              height: defaultSize * 21.5,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: defaultSize * .3,
                    spreadRadius: defaultSize * .02,
                    offset: Offset(defaultSize * .07, defaultSize * .07),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    left: defaultSize * 1.8,
                    right: defaultSize * 2,
                    bottom: defaultSize * 2),
                child: Column(
                  children: [
                    SizedBox(
                      height: defaultSize * 1.8,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context,"doNotObtain"),
                          child: Icon(Icons.arrow_back),
                        ),
                        SizedBox(
                          width: defaultSize * .8,
                        ),
                        Text(
                          "Set Drop Off",
                          style: TextStyle(
                              fontSize: defaultSize * 1.9,
                              fontFamily: "Brand-Bold"),
                        ),
                      ],
                    ),

                    ///pickup location input
                    SizedBox(
                      height: defaultSize * 1.6,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/pickicon.png",
                          height: defaultSize * 2,
                          width: defaultSize * 2,
                        ),
                        SizedBox(
                          width: defaultSize * 1.3,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(defaultSize),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black45,
                                  blurRadius: defaultSize * .2,
                                  spreadRadius: defaultSize * .03,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(defaultSize * .3),
                              child: TextField(
                                controller: _pickupTextEditingController,
                                decoration: InputDecoration(
                                  hintText: "Pickup Location",
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: defaultSize * 1.5,
                                      top: defaultSize * .8,
                                      bottom: defaultSize * .8),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    ///drop off location input
                    SizedBox(
                      height: defaultSize,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/desticon.png",
                          height: defaultSize * 2,
                          width: defaultSize * 2,
                        ),
                        SizedBox(
                          width: defaultSize * 1.3,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(defaultSize),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black45,
                                  blurRadius: defaultSize * .2,
                                  spreadRadius: defaultSize * .03,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(defaultSize * .3),
                              child: TextField(
                                onSubmitted: (val) async {
                                  placePredictionList =
                                      await LocationSuggester.locationSuggester(
                                          val);
                                  setState(() {});
                                },
                                controller: _dropOffTextEditingController,
                                decoration: InputDecoration(
                                  hintText: "Where to ",
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: defaultSize * 1.5,
                                      top: defaultSize * .8,
                                      bottom: defaultSize * .8),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: defaultSize,
            ),

            ///tile for place predictions
            placePredictionList.length > 0
                ? Flexible(
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: defaultSize * .8,
                          horizontal: defaultSize * 1.6),
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return PredictionTile(
                              defaultSize: defaultSize,
                              placePredictions: placePredictionList[index]);
                        },
                        separatorBuilder: (context, index) => Container(),
                        itemCount: placePredictionList.length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),

                      ),
                    ),
                )
                : Container(),
          ],
        ),
      ),
    );
  }
}
