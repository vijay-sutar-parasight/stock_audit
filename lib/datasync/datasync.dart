import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataSync extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Database Sync', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Container(
        child: GridView.count(crossAxisCount: 2,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: InkWell(
                onTap: (){
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => Brands()));
                },
                child: Card(color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.branding_watermark_rounded, size: 80,color: Colors.lightBlue,),
                      Text('Master Data Sync',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: InkWell(
                onTap: (){
                 // Navigator.push(context, MaterialPageRoute(builder: (context) => Formats()));
                },
                child: Card(color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.list_rounded, size: 80,color: Colors.lightBlue,),
                      Text('Audit Data Sync',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
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