import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      appBar: appbar(context, 'Dashboard', {'icons' : Icons.menu}),
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
                Icon(Icons.branding_watermark_rounded, size: 80,color: Colors.lightBlue,),
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
                Icon(Icons.list_rounded, size: 80,color: Colors.lightBlue,),
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
                Icon(Icons.library_add_rounded, size: 80,color: Colors.lightBlue,),
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
                Icon(Icons.perm_media_rounded, size: 80,color: Colors.lightBlue,),
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
                Icon(Icons.storage_rounded, size: 80,color: Colors.lightBlue,),
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
                Icon(Icons.list_alt, size: 80,color: Colors.lightBlue,),
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
                Icon(Icons.list_alt, size: 80,color: Colors.lightBlue,),
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
                Icon(Icons.storage_rounded, size: 80,color: Colors.lightBlue,),
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