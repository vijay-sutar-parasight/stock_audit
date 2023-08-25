import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/util/constants.dart' as constants;
import 'package:stock_audit/variant/variants.dart';
import 'package:stock_audit/warehouse/warehouse.dart';

import '../../db_handler.dart';
import '../models/formatmodel.dart';
import '../models/variantmodel.dart';
import '../models/warehousemodel.dart';

class AddWarehouse extends StatefulWidget{
  @override
  State<AddWarehouse> createState() => _AddWarehouse();
}

class _AddWarehouse extends State<AddWarehouse>{
  var companyId = TextEditingController();
  var warehouseName = TextEditingController();

  DBHelper? dbHelper;

  void initState(){
    super.initState();
    dbHelper = DBHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Warehouse')
      ),
      body: Container(

          child: Column(
            children: [
              TextField(
                  controller: warehouseName,
                  decoration: InputDecoration(
                      hintText: 'Warehouse Name',
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
                controller: companyId,
                decoration: InputDecoration(
                    hintText: 'Select Company',
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
                String uBrandId = companyId.text.toString();
                String uWarehouseName = warehouseName.text;
                dbHelper!.insertWarehouse(
                    WarehouseModel(
                        companyId: uBrandId,
                  warehouseName: uWarehouseName
                    )
                ).then((value) {
                  print('Data added Successfully');
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Warehouse()));
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