import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
  final double defaultSize;
  final String message;
  ProgressDialog({required this.defaultSize, required this.message});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultSize * 1.5)),
      elevation: 15,
      backgroundColor: Colors.white,
      child: Container(
        margin: EdgeInsets.all(defaultSize * 2),
        width: double.infinity,
        child: Row(
          children: [
            SizedBox(
              width: defaultSize * .6,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ),
            SizedBox(
              width: defaultSize * 2.6,
            ),
            Expanded(
              child: Text(
                message,
                style:
                    TextStyle(color: Colors.black, fontSize: defaultSize * 2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
