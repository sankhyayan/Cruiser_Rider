import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uber_clone/SnackBars/errorSnackBars.dart';
import 'package:uber_clone/allScreens/mainScreen/mainScreen.dart';
import 'package:uber_clone/allScreens/registrationScreen/registrationScreen.dart';
import 'package:uber_clone/allWidgets/progressDialog.dart';
import 'package:uber_clone/configs/constants.dart';
import 'package:uber_clone/configs/sizeConfig.dart';
import 'package:uber_clone/database/authMethods/login.dart';
import 'package:uber_clone/main.dart';

class LoginScreen extends StatelessWidget {
  static const String idScreen = "loginScreen";
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double defaultSize = SizeConfig.defaultSize;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: defaultSize * 4.7,
            ),
            Image(
              image: AssetImage("assets/images/logoTaxi.JPG"),
              width: defaultSize * 39,
              height: defaultSize * 25,
              alignment: Alignment.center,
            ),
            SizedBox(
              height: defaultSize * .15,
            ),
            Text(
              "Login as Passenger",
              style: TextStyle(
                  fontSize: defaultSize * 2.4, fontFamily: "Brand Bold"),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.all(defaultSize * 2),
              child: Column(
                children: [
                  SizedBox(
                    height: defaultSize * .15,
                  ),

                  ///Email
                  TextField(
                    controller: _emailTextEditingController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(fontSize: defaultSize * 2,fontWeight: FontWeight.bold),
                        hintStyle: TextStyle(
                            color: Colors.grey, fontSize: defaultSize)),
                    style: TextStyle(fontSize: defaultSize * 2,fontFamily: "Brand Bold"),
                  ),
                  SizedBox(
                    height: defaultSize * .15,
                  ),

                  ///Password
                  TextField(
                    controller: _passwordTextEditingController,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(fontSize: defaultSize * 2,fontWeight: FontWeight.bold),
                        hintStyle: TextStyle(
                            color: Colors.grey, fontSize: defaultSize)),
                    style: TextStyle(fontSize: defaultSize * 2,fontFamily: "Brand Bold"),
                  ),
                  SizedBox(
                    height: defaultSize * 2,
                  ),

                  ///Login Button
                  RaisedButton(
                    elevation: 10,
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    onPressed: () async {
                      if (!_emailTextEditingController.text.contains("@") ||
                          !_emailTextEditingController.text.contains(".")) {
                        ErrorSnackBars.showFloatingSnackBar(
                            context: context,
                            defaultSize: defaultSize,
                            errorText: "Invalid Email");
                      } else if (_passwordTextEditingController.text
                              .trim()
                              .length <
                          6) {
                        ErrorSnackBars.showFloatingSnackBar(
                            context: context,
                            defaultSize: defaultSize,
                            errorText:
                                "Password Must be at least 6 characters");
                      } else {
                        ///progress dialog indicator
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ProgressDialog(
                                defaultSize: defaultSize,
                                message: "Authenticating, Please wait...");
                          },
                        );

                        ///user check and log in
                        User? loggedInUser = await LoginUser.loginUser(
                          context,
                          _emailTextEditingController.text.trim(),
                          _passwordTextEditingController.text.trim(),
                        );
                        if (loggedInUser != null) {
                          usersRef
                              .child(loggedInUser.uid)
                              .once()
                              .then((DataSnapshot snapshot) async {
                            if (await snapshot.value != null) {
                              Navigator.pop(context);
                              Navigator.pushNamedAndRemoveUntil(context,
                                  MainScreen.idScreen, (route) => false);
                              ErrorSnackBars.showFloatingSnackBar(
                                  context: context,
                                  defaultSize: defaultSize,
                                  errorText: "Logged In Successfully");
                            } else {
                              await LoginUser.signOut();
                              ErrorSnackBars.showFloatingSnackBar(
                                  context: context,
                                  defaultSize: defaultSize,
                                  errorText: "Error. Could not Log In");
                              Navigator.pop(context);
                            }
                          });
                        } else {
                          ErrorSnackBars.showFloatingSnackBar(
                              context: context,
                              defaultSize: defaultSize,
                              errorText: "No such user exists");
                          Navigator.pop(context);
                        }
                      }
                    },
                    color: Constants.kPrimaryColor,
                    textColor: Colors.white,
                    child: Container(
                      height: defaultSize * 5,
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontSize: defaultSize * 1.8,
                              fontFamily: "Brand Bold"),
                        ),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(defaultSize * 2.4),
                    ),
                  ),
                  SizedBox(
                    height: defaultSize * 1.5,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: defaultSize),
                    child: Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontFamily: "Brand Bold",
                        fontSize: defaultSize * 1.55,
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                  ),

                  ///Registration Button
                  RaisedButton(
                    elevation: 10,
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context,
                          RegistrationScreen.idScreen, (route) => false);
                    },
                    color: Constants.kPrimaryColor,
                    textColor: Colors.white,
                    child: Container(
                      height: defaultSize * 5,
                      child: Center(
                        child: Text(
                          "Register",
                          style: TextStyle(
                              fontSize: defaultSize * 1.8,
                              fontFamily: "Brand Bold"),
                        ),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(defaultSize * 2.4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
