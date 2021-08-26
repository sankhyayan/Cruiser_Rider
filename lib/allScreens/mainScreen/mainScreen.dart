import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/allScreens/mainScreen/widgets/cabRequestSheet.dart';
import 'package:uber_clone/allScreens/mainScreen/widgets/cancelRide.dart';
import 'package:uber_clone/allScreens/mainScreen/widgets/findingDriver.dart';
import 'package:uber_clone/allScreens/mainScreen/widgets/locationEntrySheet.dart';
import 'package:uber_clone/allScreens/mainScreen/widgets/profileDrawerContainer.dart';
import 'package:uber_clone/configs/GeofireMethods/GeoFireListener.dart';
import 'package:uber_clone/configs/locationRequests/assistantMethods.dart';
import 'package:uber_clone/configs/locationRequests/userGeoLocator.dart';
import 'package:uber_clone/configs/providers/appDataProvider.dart';
import 'package:uber_clone/configs/resetData.dart';
import 'package:uber_clone/configs/sizeConfig.dart';
import 'package:uber_clone/database/authMethods/CurrentUser.dart';

class MainScreen extends StatefulWidget {
  static const String idScreen = "mainScreen";
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  final CameraPosition _initialCamPos = CameraPosition(
    target: LatLng(22.570824771878623, 88.37058693225569),
    zoom: 14.4746,
  );
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  ///setting current user Info
  @override
  void initState() {
    super.initState();
    CurrentUser.getCurrentUserInfo(context);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double defaultSize = SizeConfig.defaultSize;

    ///bottom location sheet height adder
    final double locationBottomSheetHeight =
        Provider.of<AppData>(context).response == "obtainDirection"
            ? 0.0
            : defaultSize;

    ///request cab bottom sheet height adder
    final double requestCabBottomSheetHeight =
        (Provider.of<AppData>(context).response == "obtainDirection" &&
                !Provider.of<AppData>(context).rideRequest)
            ? defaultSize
            : 0.0;

    ///animate map? checker
    if (Provider.of<AppData>(context).animateMap)
      newGoogleMapController.animateCamera(
        CameraUpdate.newLatLngBounds(
            Provider.of<AppData>(context).latLngBounds, 70),
      );
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,

        ///app bar
        appBar: AppBar(
          elevation: 10,
          backgroundColor: Colors.black,
          title: Text("Main Screen"),

          ///hamburger button for drawer
          leading: Container(
            child: Provider.of<AppData>(context).response != "obtainDirection"
                ? IconButton(
                    onPressed: () => scaffoldKey.currentState!.openDrawer(),
                    icon: Icon(
                      Icons.menu,
                      color: Colors.black,
                    ),
                  )
                : IconButton(
                    onPressed: () async {
                      ResetData.resetData(context);
                      newGoogleMapController.animateCamera(
                          CameraUpdate.newCameraPosition(
                              await UserGeoLocation.getCamPosition()));

                      await AssistantMethods.searchCoordinates(
                          await UserGeoLocation.locatePosition(), context);
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.black,
                    )),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
          ),
        ),

        ///drawer
        drawer: Container(
          width: defaultSize * 25.5,
          child: Drawer(
            child: ProfileDrawerContainer(defaultSize: defaultSize),
          ),
        ),

        ///Body - Map+Location input
        body: Stack(
          children: [
            ///google map
            Container(
              padding: EdgeInsets.only(bottom: defaultSize * 22),
              child: GoogleMap(
                initialCameraPosition: _initialCamPos,
                mapType: MapType.normal,
                myLocationButtonEnabled: true,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: false,
                myLocationEnabled: true,
                polylines: Provider.of<AppData>(context).polylineSet,
                markers: Provider.of<AppData>(context).mapMarkers,
                circles: Provider.of<AppData>(context).mapCircles,
                onMapCreated: (GoogleMapController controller) async {
                  _controllerGoogleMap.complete(controller);
                  newGoogleMapController = controller;

                  ///camera update position to current position on start

                  newGoogleMapController.animateCamera(
                      CameraUpdate.newCameraPosition(
                          await UserGeoLocation.getCamPosition()));

                  await AssistantMethods.searchCoordinates(
                      await UserGeoLocation.locatePosition(), context);

                  await GeoFireListener.initGeoFireListener(context);
                },
              ),
            ),

            ///Location input sheet
            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: AnimatedSize(
                vsync: this,
                duration: Duration(milliseconds: 170),
                curve: Curves.bounceIn,
                child: LocationEntryBottomSheet(
                  defaultSize: locationBottomSheetHeight,
                ),
              ),
            ),

            ///cab request sheet
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: AnimatedSize(
                vsync: this,
                duration: Duration(milliseconds: 440),
                curve: Curves.bounceIn,
                child: CabRequestBottomSheet(
                  defaultSize: requestCabBottomSheetHeight,
                ),
              ),
            ),

            ///finding driver
            Provider.of<AppData>(context).rideRequest
                ? Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: FindingDriver(
                      defaultSize: defaultSize,
                    ),
                  )
                : Container(),

            ///cancel ride
            Provider.of<AppData>(context).rideRequest
                ? CancelRide(
                    defaultSize: defaultSize,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
