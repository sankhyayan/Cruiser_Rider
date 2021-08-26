import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/configs/providers/appDataProvider.dart';
import 'package:uber_clone/main.dart';
import 'package:uber_clone/models/userDataFromSnapshot.dart';

class CurrentUser {
  static void getCurrentUserInfo(BuildContext context) async {
    User firebaseUser = FirebaseAuth.instance.currentUser!;
    String userId = firebaseUser.uid;
    DatabaseReference currentUserReference =
        usersRef.child(userId);
    await currentUserReference.once().then((DataSnapshot _dataSnapshot) {
      if (_dataSnapshot.value != null) {
        UserDataFromSnapshot userCurrentInfo =
            UserDataFromSnapshot.fromSnapshot(_dataSnapshot);
        Provider.of<AppData>(context, listen: false)
            .getCurrentUserInfo(userCurrentInfo);
      }
    });
  }
}
