import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_audit/dashboard.dart';
import 'package:stock_audit/db_handler.dart';

import 'login.dart';
import 'main.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  static const String KEYLOGIN="login";
  String lastSyncDate = "";
  DBHelper? dbHelper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginCheck();
    dbHelper = DBHelper();
    var syncDate = dbHelper!.getLastSyncDate();
    syncDate.then((value) => {
    lastSyncDate = value,
    dbHelper!.fetchAllData(lastSyncDate)
    }
    );

  }


  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Container(
       color: Colors.blue,
       child: Center(child: Text('Stock Audit', style: TextStyle(
         fontSize: 34,
         fontWeight: FontWeight.w700,
         color: Colors.white
       ),))
     )

   );
  }

  Future<void> loginCheck() async {
    var sharedPref = await SharedPreferences.getInstance();
    var isLoggedIn = sharedPref.getBool(KEYLOGIN);


    Timer(Duration(seconds: 3),(){
      if(isLoggedIn != null){
        if(isLoggedIn){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard()));
        }else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
        }
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
      }
    });
  }
}