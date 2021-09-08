import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorSnackBars {
  static void showFloatingSnackBar(
      {required BuildContext context,required double defaultSize,required String errorText}) {
    final snackBar = SnackBar(
      content: Container(
        height: defaultSize * 2,
        width: defaultSize * 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              errorText,
              style:
                  TextStyle(fontSize: defaultSize * 1.3, color: Colors.black,fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            Icon(
              Icons.info_outline,
              size: defaultSize * 2,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      duration: Duration(seconds: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultSize),
      ),
      elevation: 5,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(vertical: defaultSize*2,horizontal: defaultSize*5),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
  }
