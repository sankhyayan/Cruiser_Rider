import 'package:flutter/material.dart';
import 'package:uber_clone/allWidgets/progressDialog.dart';
import 'package:uber_clone/configs/locationRequests/addressDetails.dart';
import 'package:uber_clone/models/placePredictions.dart';

class PredictionTile extends StatelessWidget {
  final double defaultSize;
  final PlacePredictions placePredictions;
  PredictionTile({required this.defaultSize, required this.placePredictions});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(defaultSize * .8),
      enableFeedback: false,
      onTap: () async {
        showDialog(
          context: context,
          builder: (context) => ProgressDialog(
              defaultSize: defaultSize,
              message: "Setting drop Location, Please wait..."),
        );
        await AddressDetails.getAddressDetails(placePredictions, context);
        Navigator.pop(context);
        Navigator.pop(context,"obtainDirection");
      },
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: defaultSize,
            ),
            Row(
              children: [
                Icon(Icons.add_location),
                SizedBox(
                  width: defaultSize * 1.4,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: defaultSize * .5,
                      ),
                      Text(
                        (placePredictions.type!.trim().length +
                                    placePredictions.road!.trim().length) !=
                                0
                            ? placePredictions.type! +
                                ", " +
                                placePredictions.road!
                            : placePredictions.formatted!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: defaultSize * 1.6,
                        ),
                      ),
                      SizedBox(
                        height: defaultSize * .6,
                      ),
                      Text(
                        (placePredictions.subUrb!.trim().length +
                                    placePredictions.city!.trim().length +
                                    placePredictions.postcode!.trim().length) !=
                                0
                            ? placePredictions.subUrb! +
                                ", " +
                                placePredictions.city! +
                                "-" +
                                placePredictions.postcode!
                            : " ",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: defaultSize * 1.2, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: defaultSize,
            ),
          ],
        ),
      ),
    );
  }
}
