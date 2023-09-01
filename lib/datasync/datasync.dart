import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/db_handler.dart';
import 'package:stock_audit/jsondata/GetBrandData.dart';
import 'package:stock_audit/util/constants.dart' as constants;
import 'package:http/http.dart' as http;

import '../models/brandmodel.dart';


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
  bool company = true;

  DBHelper? dbHelper;
  List<String> _brandList = [];
  List<GetBrandData> _brandMasterList = [];

  @override
  void initState(){
    super.initState();
    dbHelper = DBHelper();
  }
    Future<void> getBrandData() async {
      _brandMasterList = await dbHelper!.getBrandListArray();
      for (int i = 0; i < _brandMasterList.length; i++) {

        _brandList.add(_brandMasterList[i].toString());
        setState(() {

        });
      }
    }

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
            title: Text("Company"),
            value: company, onChanged: (val){
          setState((){
            company = val!;
          });
        }),
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
              child: ElevatedButton(onPressed: () async {
                if(brands == true){
                  getBrandData();
                  String url = "${constants.apiBaseURL}/synchronizedata";
                  final response = await http.post(Uri.parse(url),body: _brandList);
                print(response.body);
                }

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