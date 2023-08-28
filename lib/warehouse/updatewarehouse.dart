import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/brand/brands.dart';
import 'package:stock_audit/util/constants.dart' as constants;
import 'package:stock_audit/variant/variants.dart';
import 'package:stock_audit/warehouse/warehouse.dart';

import '../audit/audit.dart';
import '../db_handler.dart';
import '../jsondata/GetCompanyData.dart';
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

  List<String> _CompanyList = [];
  List<GetCompanyData> _companyMasterList = [];

  DBHelper? dbHelper;

  @override
  void initState(){
    super.initState();
    dbHelper = DBHelper();
    getCompanyData();
  }

  Future<void> getCompanyData() async {
    _companyMasterList = await dbHelper!.getCompanyListArray();
    for (int i = 0; i < _companyMasterList.length; i++) {

      _CompanyList.add(_companyMasterList[i].companyName!);
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final updateWarehouse = ModalRoute.of(context)!.settings.arguments as WarehouseModel;
    companyId.text = updateWarehouse.companyId!;
    warehouseName.text = updateWarehouse.warehouseName!;
    recordId = updateWarehouse.warehouseId!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Warehouse')
      ),
      body: Container(
          child: Column(
            children: [
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
              Container(height: 11),

              DropdownSearch<String>(
                popupProps: PopupProps.menu(
                  showSelectedItems: true,
                  disabledItemFn: (String s) => s.startsWith('I'),
                ),
                items: _CompanyList,
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Company",
                    hintText: "Select Company",
                  ),
                ),
                onChanged: (val){

                  companyId.text = val!;
                },
                selectedItem: companyId.text,
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