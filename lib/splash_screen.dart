import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_audit/dashboard.dart';
import 'package:stock_audit/db_handler.dart';
import 'package:stock_audit/util/constants.dart' as constants;
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
       color: constants.mainColor,
       child: Center(
         child:
         // Image(image: AssetImage('assets/logo.png'))
         Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             Image(image: AssetImage(constants.logo),width: 120,height: 120,),
             const Text("Stock Audit",style: TextStyle(color: Colors.white,fontSize: 25)),
           ],
         ),
       )
     )

   );
  }

  Future<void> loginCheck() async {
    var sharedPref = await SharedPreferences.getInstance();
    var isLoggedIn = sharedPref.getBool(KEYLOGIN);


    Timer(Duration(seconds: 3 ),(){
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