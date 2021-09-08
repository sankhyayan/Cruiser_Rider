import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uber_clone/allOverAppWidgets/errorSnackBars.dart';
import 'package:uber_clone/allOverAppWidgets/progressDialog.dart';
import 'package:uber_clone/allScreens/loginScreen/loginScreen.dart';
import 'package:uber_clone/allScreens/mainScreen/mainScreen.dart';
import 'package:uber_clone/configs/sizeConfig.dart';
import 'package:uber_clone/database/authMethods/register.dart';
import 'package:uber_clone/models/userDataToMap.dart';

import '../../main.dart';

class RegistrationScreen extends StatelessWidget {
  static const String idScreen = "registerScreen";
  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _phoneTextEditingController =
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
              height: defaultSize * 2.7,
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
              "Register as Passenger",
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

                  ///UserName
                  TextField(
                    controller: _nameTextEditingController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "User Name",
                        labelStyle: TextStyle(
                            fontSize: defaultSize * 2,
                            fontWeight: FontWeight.bold),
                        hintStyle: TextStyle(
                            color: Colors.grey, fontSize: defaultSize)),
                    style: TextStyle(
                        fontSize: defaultSize * 2, fontFamily: "Brand Bold"),
                  ),
                  SizedBox(
                    height: defaultSize * .15,
                  ),

                  ///Email
                  TextField(
                    controller: _emailTextEditingController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                            fontSize: defaultSize * 2,
                            fontWeight: FontWeight.bold),
                        hintStyle: TextStyle(
                            color: Colors.grey, fontSize: defaultSize)),
                    style: TextStyle(
                        fontSize: defaultSize * 2, fontFamily: "Brand Bold"),
                  ),
                  SizedBox(
                    height: defaultSize * .15,
                  ),

                  ///Phone
                  TextField(
                    controller: _phoneTextEditingController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: "Phone",
                        labelStyle: TextStyle(
                            fontSize: defaultSize * 2,
                            fontWeight: FontWeight.bold),
                        hintStyle: TextStyle(
                            color: Colors.grey, fontSize: defaultSize)),
                    style: TextStyle(
                        fontSize: defaultSize * 2, fontFamily: "Brand Bold"),
                  ),
                  SizedBox(
                    height: defaultSize * .15,
                  ),

                  ///Password
                  TextField(
                    controller: _passwordTextEditingController,
                    decoration: InputDecoration(
                      labelText: "Password",
                        labelStyle: TextStyle(
                            fontSize: defaultSize * 2,
                            fontWeight: FontWeight.bold),
                        hintStyle: TextStyle(
                            color: Colors.grey, fontSize: defaultSize)),
                    style: TextStyle(
                        fontSize: defaultSize * 2, fontFamily: "Brand Bold"),
                  ),
                  SizedBox(
                    height: defaultSize * 2,
                  ),

                  ///Registration Button
                  RaisedButton(
                    elevation: 10,
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    onPressed: () async {
                      ///name Controller
                      if (_nameTextEditingController.text.trim().length < 4) {
                        ErrorSnackBars.showFloatingSnackBar(
                            defaultSize: defaultSize,
                            errorText: "Name must be greater than 4 characters",
                            context: context);
                      }

                      ///email Controller
                      else if (!_emailTextEditingController.text
                          .contains("@")) {
                        ErrorSnackBars.showFloatingSnackBar(
                            context: context,
                            defaultSize: defaultSize,
                            errorText: "Invalid Email");
                      }

                      ///phone Controller
                      else if (_phoneTextEditingController.text.trim().length != 10) {
                        ErrorSnackBars.showFloatingSnackBar(
                            context: context,
                            defaultSize: defaultSize,
                            errorText: "Invalid Phone Number");
                      }

                      ///password Controller
                      else if (_passwordTextEditingController.text.trim().length < 6) {
                        ErrorSnackBars.showFloatingSnackBar(
                            context: context,
                            defaultSize: defaultSize,
                            errorText:
                                "Password Must be at least 6 characters");
                      }

                      ///User Creator function
                      else {
                        ///progress dialog indicator
                        showDialog(
                            context: context,
                            builder: (context) {
                              return ProgressDialog(
                                  defaultSize: defaultSize,
                                  message: "Registering User, Please wait...");
                            });
                        User? createdUser = await RegisterUser.registerNewUser(
                            context,
                            _emailTextEditingController.text.trim(),
                            _passwordTextEditingController.text.trim(),);
                        if (createdUser != null) {
                          Map<String, dynamic> createdUserMap =
                              UserDataToMap.toMap(
                            UserDataToMap(
                              name: _nameTextEditingController.text.trim(),
                              email: _emailTextEditingController.text.trim(),
                              phone: _phoneTextEditingController.text.trim(),
                            ),
                          );
                          await usersRef
                              .child(createdUser.uid)
                              .set(createdUserMap);
                          ErrorSnackBars.showFloatingSnackBar(
                              context: context,
                              defaultSize: defaultSize,
                              errorText: "User Created");
                          Navigator.pushNamedAndRemoveUntil(
                              context, MainScreen.idScreen, (route) => false);
                        } else {
                          ErrorSnackBars.showFloatingSnackBar(
                              context: context,
                              defaultSize: defaultSize,
                              errorText: "User could not created");
                          Navigator.pop(context);
                        }
                      }
                    },
                    color: Colors.black,
                    textColor: Colors.white,
                    child: Container(
                      height: defaultSize * 5,
                      child: Center(
                        child: Text(
                          "Create Account",
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

                  ///Login Button
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: defaultSize),
                        child: Text(
                          "Already have an account?",
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontFamily: "Brand Bold",
                            fontSize: defaultSize * 1.2,
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                      ),

                      ///Login Button
                      SizedBox(
                        width: defaultSize,
                      ),
                      Expanded(
                        child: RaisedButton(
                          elevation: 10,
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(context,
                                LoginScreen.idScreen, (route) => false);
                          },
                          color: Colors.black,
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
                            borderRadius:
                                BorderRadius.circular(defaultSize * 2.4),
                          ),
                        ),
                      ),
                    ],
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
