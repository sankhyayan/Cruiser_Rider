import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/configs/apiConfigs.dart';
import 'package:uber_clone/configs/providers/appDataProvider.dart';
import 'package:http/http.dart' as http;

class NotifyNearestDriver {
  static Future<void> notify(
      String token, BuildContext context, String rideRequestId) async {
    String dropOffDestination =
        Provider.of<AppData>(context, listen: false).dropOffLocation.placeName!;

    ///notification header Map
    Map<String, String> headerMap = {
      "Content-Type": "application/json",
      "Authorization": "key=$serverKey",
    };

    ///notification pop up body Map
    Map<String, dynamic> notificationMap = {
      "body": "DropOff, $dropOffDestination",
      "title": "New Ride Request",
      "android_channel_id": "high_importance_channel",
    };

    ///notification dataMap
    Map<String, dynamic> dataMap = {
      "click_action": "FLUTTER_NOTIFICATION_CLICK",
      "id": "1",
      "status": "done",
      "ride_request_id": rideRequestId,
    };

    ///final notification map to be sent
    Map<String, dynamic> sendNotificationMap = {
      "notification": notificationMap,
      "priority": "high",
      "data": dataMap,
      "to": token
    };

    ///send notification REST request
    try {
      var res = await http.post(
          Uri.parse("https://fcm.googleapis.com/fcm/send"),
          headers: headerMap,
          body: jsonEncode(sendNotificationMap));
      print("Request Status: " + res.statusCode.toString());
    } on Exception catch (e) {
      print(e);
    }
  }
}
