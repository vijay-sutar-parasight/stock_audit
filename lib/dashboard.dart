import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/brands.dart';
import 'package:stock_audit/datasync.dart';
import 'package:stock_audit/descriptions.dart';
import 'package:stock_audit/variants.dart';

import 'auditentries.dart';
import 'formats.dart';

class Dashboard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard', style: TextStyle(color: Colors.white)),
        centerTitle: true,
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
                Icon(Icons.branding_watermark_rounded, size: 120,color: Colors.lightBlue,),
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
                Icon(Icons.list_rounded, size: 120,color: Colors.lightBlue,),
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
                Icon(Icons.library_add_rounded, size: 120,color: Colors.lightBlue,),
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
                Icon(Icons.perm_media_rounded, size: 120,color: Colors.lightBlue,),
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => AuditEntries()));
          },
          child: Card(color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.list_alt, size: 120,color: Colors.lightBlue,),
                Text('Audit Entries',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
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
                Icon(Icons.storage_rounded, size: 120,color: Colors.lightBlue,),
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