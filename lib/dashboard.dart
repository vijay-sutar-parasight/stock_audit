import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_audit/brand/brands.dart';
import 'package:stock_audit/company/company.dart';
import 'package:stock_audit/datasync/datasync.dart';
import 'package:stock_audit/description/descriptions.dart';
import 'package:stock_audit/splash_screen.dart';
import 'package:stock_audit/variant/variants.dart';
import 'package:stock_audit/warehouse/warehouse.dart';
import 'package:stock_audit/audit/audit.dart';
import 'package:stock_audit/format/formats.dart';
import 'package:stock_audit/util/constants.dart' as constants;

import 'appbar.dart';
import 'login.dart';

class Dashboard extends StatefulWidget{
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard", style: TextStyle(color: Colors.white)),
        centerTitle: false,
        actions: <Widget>[
          PopupMenuButton<String>(
            color: Colors.white,
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
      ),
      body: Container(
        child: GridView.count(crossAxisCount: 2,
    children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Brands()));
            },
            child: Card(color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon(Icons.branding_watermark_rounded, size: 80,color: constants.mainColor,),
                //SvgPicture.asset("assets/icons/test.svg", width:60, height:60),
                Image(image: AssetImage(constants.brandIcon),width: 60,height: 60,),
                Text('Brands',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              ],
            ),
            ),
          ),
        ),
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Formats()));
          },
          child: Card(color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage(constants.formatIcon),width: 60,height: 60,),
                Text('Formats',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Variants()));
          },
          child: Card(color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage(constants.variantIcon),width: 60,height: 60,),
                Text('Variants',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Descriptions()));
          },
          child: Card(color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage(constants.descriptionIcon),width: 60,height: 60,),
                Text('Descriptions',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Warehouse()));
          },
          child: Card(color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage(constants.warehouseIcon),width: 60,height: 60,),
                Text('Warehouse',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Company()));
          },
          child: Card(color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.factory_outlined, size: 60,color: constants.mainColor,),
                Text('Company',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Audit()));
          },
          child: Card(color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage(constants.auditIcon),width: 60,height: 60,),
                Text('Audit',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => DataSync()));
          },
          child: Card(color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage(constants.datasyncIcon),width: 60,height: 60,),
                Text('Data Sync',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
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