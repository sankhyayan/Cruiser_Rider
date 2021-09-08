import 'package:flutter/material.dart';

class NoAvailableDriverDialog extends StatelessWidget {
  final double defaultSize;
  NoAvailableDriverDialog({required this.defaultSize});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultSize * 2),
      ),
      elevation: defaultSize * .5,
      backgroundColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(defaultSize * 1.5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: defaultSize,
            ),
            Padding(
              padding:EdgeInsets.all(defaultSize*.8),
              child: Text(
                "No Driver Found",
                style: TextStyle(
                    fontSize: defaultSize * 2.2, fontFamily: "Brand Bold"),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultSize*2.5,vertical: defaultSize*2),
              child: Text(
                "No available drivers nearby, Please try again shortly",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: defaultSize*1.8,fontFamily: "Brand Bold"),
              ),
            ),
            SizedBox(
              height: defaultSize * 3,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
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
                        "CLOSE",
                        style: TextStyle(
                            color: Colors.white, fontSize: defaultSize * 2),
                      ),
                      Icon(
                        Icons.close_sharp,
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
