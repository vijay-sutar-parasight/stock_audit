import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/brand/brands.dart';
import 'package:stock_audit/util/constants.dart' as constants;

import '../audit/audit.dart';
import '../db_handler.dart';
import '../models/auditmodel.dart';
import '../models/brandmodel.dart';
import '../models/formatmodel.dart';
import 'formats.dart';

class UpdateFormat extends StatefulWidget{
  @override
  State<UpdateFormat> createState() => _UpdateFormat();
}

class _UpdateFormat extends State<UpdateFormat>{
  var brandId = TextEditingController();
  var formatName = TextEditingController();
  var recordId;

  DBHelper? dbHelper;

  @override
  void initState(){
    super.initState();
    dbHelper = DBHelper();
  }

  @override
  Widget build(BuildContext context) {

    final updateFormat = ModalRoute.of(context)!.settings.arguments as FormatModel;
    brandId.text = updateFormat.brandId!;
    formatName.text = updateFormat.formatName!;
    recordId = updateFormat.formatId!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Format')
      ),
      body: Container(
          child: Column(
            children: [
              TextField(
                controller: brandId,
                decoration: InputDecoration(
                    hintText: 'Select Brand',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(
                            color: Colors.deepOrange,
                            width: 2
                        )
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(
                            color: Colors.blueAccent,
                            width: 2
                        )
                    ),
                    prefixIcon: Icon(Icons.add_business, color: Colors.orange)
                ),
              ),
              Container(height: 11),
              TextField(
                  controller: formatName,
                  decoration: InputDecoration(
                      hintText: 'Format Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          )
                      ),
                      prefixIcon: Icon(Icons.list_alt, color: Colors.orange)

                  )
              ),
              Container(height: 20),

              ElevatedButton(onPressed: (){
                String uBrandId = brandId.text.toString();
                String uFormatName = formatName.text;
                dbHelper!.updateFormat(
                    FormatModel(
                      formatId: recordId,
                  brandId: uBrandId,
                      formatName: uFormatName,
                    )
                ).then((value) {
                  print('Data added Successfully');
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Formats()));
                }).onError((error, stackTrace) {
                  print(error.toString());
                });
              }, child: Text(
                  'Save'
              ))
            ],
          )),
    );
  }
}