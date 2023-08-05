import 'dart:async';

import 'package:flutter/material.dart';

import 'main.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage(title: 'Stock Audit',)));
    });
  }


  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Container(
       color: Colors.blue,
       child: Center(child: Text('Warehouse Stock Audit', style: TextStyle(
         fontSize: 34,
         fontWeight: FontWeight.w700,
         color: Colors.white
       ),))
     )

   );
  }
}