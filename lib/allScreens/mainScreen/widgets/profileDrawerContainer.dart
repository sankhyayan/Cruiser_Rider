import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/allScreens/loginScreen/loginScreen.dart';
import 'package:uber_clone/configs/providers/appDataProvider.dart';
import 'package:uber_clone/database/authMethods/login.dart';

class ProfileDrawerContainer extends StatelessWidget {
  final double defaultSize;
  const ProfileDrawerContainer({required this.defaultSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: ListView(
        children: [
          ///drawer header - Profile page visit
          Container(
            height: defaultSize * 9.5,
            child: DrawerHeader(
              margin: EdgeInsets.only(bottom: defaultSize * .5),
              padding: EdgeInsets.symmetric(
                vertical: defaultSize,
                horizontal: defaultSize * 1.3,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Provider.of<AppData>(context)
                            .currentUserInfo
                            .name!, //todo check if listen false is necessary?
                        style: TextStyle(
                            fontSize: defaultSize * 1.7,
                            fontFamily: "Brand-Bold"),
                      ),
                      SizedBox(height: defaultSize * .7),
                      Text(
                        "Stars           5 ★",
                      ),
                    ],
                  ),
                  SizedBox(width: defaultSize * 1.6),
                  Image.asset(
                    "assets/images/user_icon.png",
                    height: defaultSize * 6.5,
                    width: defaultSize * 6.5,
                  ),
                ],
              ),
            ),
          ),

          ///drawer body Controllers
          Column(
            children: [
              ListTile(
                horizontalTitleGap: defaultSize * .5,
                leading: Icon(Icons.history, color: Colors.white),
                title: Text("History",
                    style: TextStyle(
                        fontSize: defaultSize * 1.5, color: Colors.white)),
              ),
              ListTile(
                horizontalTitleGap: defaultSize * .5,
                leading: Icon(Icons.person, color: Colors.white),
                title: Text("Visit Profile",
                    style: TextStyle(
                        fontSize: defaultSize * 1.5, color: Colors.white)),
              ),
              ListTile(
                horizontalTitleGap: defaultSize * .5,
                leading: Icon(Icons.info, color: Colors.white),
                title: Text("About",
                    style: TextStyle(
                        fontSize: defaultSize * 1.5, color: Colors.white)),
              ),
              GestureDetector(
                onTap: () async {
                  await LoginUser.signOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginScreen.idScreen, (route) => false);
                },
                child: ListTile(
                  horizontalTitleGap: defaultSize * .5,
                  leading: Icon(
                    Icons.logout_rounded,
                    color: Colors.white,
                  ),
                  title: Text("Log Out",
                      style: TextStyle(
                          fontSize: defaultSize * 1.5, color: Colors.white)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
