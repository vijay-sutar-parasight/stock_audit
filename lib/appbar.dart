import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_audit/splash_screen.dart';
import 'package:stock_audit/util/constants.dart' as constants;

import 'login.dart';

PreferredSizeWidget appbar(BuildContext context, String title, dynamic otherData) {
  return AppBar(
    title: Text(title, style: TextStyle(color: Colors.white)),
    centerTitle: false,
    actions: <Widget>[
      PopupMenuButton<String>(
        onSelected: (String value) async {
          switch (value) {
            case 'Logout':
              var sharedPref = await SharedPreferences.getInstance();
              sharedPref.setBool(SplashScreenState.KEYLOGIN, false);
              constants.Notification("Logged Out Successfully");
              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login()), (route) => false);
              break;
          }
        },
        itemBuilder: (BuildContext context) {
          return {'Logout'}.map((String choice) {
            return PopupMenuItem<String>(
              value: choice,
              child: Text(choice),
            );
          }).toList();
        },
      ),
    ],
  );
}

// Future<void> handleClick(String value) async {
//   switch (value) {
//     case 'Logout':
//       var sharedPref = await SharedPreferences.getInstance();
//       sharedPref.setBool(SplashScreenState.KEYLOGIN, false);
//       constants.Notification("Logged Out Successfully");
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
//       break;
//   }
// }