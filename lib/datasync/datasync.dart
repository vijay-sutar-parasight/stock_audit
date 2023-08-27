import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataSync extends StatefulWidget{
  @override
  State<DataSync> createState() => _DataSyncState();
}

class _DataSyncState extends State<DataSync> {
  bool brands = true;

  bool formats = true;

  bool variants = true;

  bool descriptions = true;

  bool warehouses = true;

  bool audit = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Database Sync', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
    body: Column(
      children: [
        CheckboxListTile(
            title: Text("Brands"),
            value: brands, onChanged: (val){
          setState((){
                brands = val!;
              });
        }),
        CheckboxListTile(
            title: Text("Formats"),
            value: formats, onChanged: (val){
          setState((){
            formats = val!;
          });
        }),
        CheckboxListTile(
            title: Text("Variants"),
            value: variants, onChanged: (val){
          setState((){
            variants = val!;
          });
        }),
        CheckboxListTile(
            title: Text("Descriptions"),
            value: descriptions, onChanged: (val){
          setState((){
            descriptions = val!;
          });
        }),
        CheckboxListTile(
            title: Text("Warehouse"),
            value: warehouses, onChanged: (val){
          setState((){
            warehouses = val!;
          });
        }),
        CheckboxListTile(
            title: Text("Audit & Audit Entries"),
            value: audit, onChanged: (val){
          setState((){
            audit = val!;
          });
        }),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: ElevatedButton(onPressed: (){

              }, child: Text(
                  'Import From Server'
              )),
            ),
            SizedBox(width: 20,),
            Flexible(
              child: ElevatedButton(onPressed: (){
                print(brands);
              }, child: Text(
                  'Sync To Server'
              )),
            )
          ],
        ),
        

      ],
    )
    );
  }
}