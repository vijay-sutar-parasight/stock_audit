import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/brand/brands.dart';
import 'package:stock_audit/util/constants.dart' as constants;
import 'package:stock_audit/variant/variants.dart';
import 'package:stock_audit/warehouse/warehouse.dart';

import '../audit/audit.dart';
import '../db_handler.dart';
import '../models/auditmodel.dart';
import '../models/brandmodel.dart';
import '../models/formatmodel.dart';
import '../models/variantmodel.dart';
import '../models/warehousemodel.dart';

class UpdateWarehouse extends StatefulWidget{
  @override
  State<UpdateWarehouse> createState() => _UpdateWarehouse();
}

class _UpdateWarehouse extends State<UpdateWarehouse>{
  var companyId = TextEditingController();
  var warehouseName = TextEditingController();
  var recordId;

  DBHelper? dbHelper;

  @override
  void initState(){
    super.initState();
    dbHelper = DBHelper();
  }

  @override
  Widget build(BuildContext context) {

    final updateWarehouse = ModalRoute.of(context)!.settings.arguments as WarehouseModel;
    companyId.text = updateWarehouse.companyId!;
    warehouseName.text = updateWarehouse.warehouseName!;
    recordId = updateWarehouse.warehouseId!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Variant')
      ),
      body: Container(
          child: Column(
            children: [
              TextField(
                controller: companyId,
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
                  controller: warehouseName,
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
                String uCompanyId = companyId.text.toString();
                String uFormatName = warehouseName.text;
                dbHelper!.updateWarehouse(
                    WarehouseModel(
                      warehouseId: recordId,
                  companyId: uCompanyId,
                      warehouseName: uFormatName,
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