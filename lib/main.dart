import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/allScreens/loginScreen/loginScreen.dart';
import 'package:uber_clone/allScreens/mainScreen/mainScreen.dart';
import 'package:uber_clone/allScreens/registrationScreen/registrationScreen.dart';
import 'package:uber_clone/configs/providers/appDataProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(UberClone());
}

final DatabaseReference usersRef = FirebaseDatabase(
        databaseURL:
            "https://uber-clone-64d20-default-rtdb.asia-southeast1.firebasedatabase.app")
    .reference()
    .child("Users");

class UberClone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        title: 'Uber Clone',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: FirebaseAuth.instance.currentUser == null
            ? LoginScreen.idScreen
            : MainScreen.idScreen,
        routes: {
          RegistrationScreen.idScreen: (context) => RegistrationScreen(),
          LoginScreen.idScreen: (context) => LoginScreen(),
          MainScreen.idScreen: (context) => MainScreen(),
        },
      ),
    );
  }
}
