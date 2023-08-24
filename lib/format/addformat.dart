import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/util/constants.dart' as constants;

import '../../db_handler.dart';
import '../models/formatmodel.dart';
import 'formats.dart';

class AddFormat extends StatefulWidget{
  @override
  State<AddFormat> createState() => _AddFormat();
}

class _AddFormat extends State<AddFormat>{
  var brandId = TextEditingController();
  var formatName = TextEditingController();

  DBHelper? dbHelper;

  void initState(){
    super.initState();
    dbHelper = DBHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Format')
      ),
      body: Container(

          child: Column(
            children: [
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
              Container(height: 11),
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
              Container(height: 20),
              ElevatedButton(onPressed: (){
                String uBrandId = brandId.text.toString();
                String uFormatName = formatName.text;
                dbHelper!.insertFormat(
                    FormatModel(
                  brandId: uBrandId,
                  formatName: uFormatName
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