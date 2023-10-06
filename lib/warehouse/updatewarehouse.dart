import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/brand/brands.dart';
import 'package:stock_audit/util/constants.dart' as constants;
import 'package:stock_audit/variant/variants.dart';
import 'package:stock_audit/warehouse/warehouse.dart';

import '../appbar.dart';
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
  String selectedValue = "";
  Map<String, String> companyData = {};

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
      // _CompanyList.add(_companyMasterList[i].companyName!);
      companyData[_companyMasterList[i].companyId!.toString()] = _companyMasterList[i].companyName!;
    }
    setState(() {

    });
  }

  getCompanyName(companyId){
    var companyName = "";
    if(companyId != ''){
      companyName = companyData[companyId].toString();
    }
    return companyName;
  }

  @override
  Widget build(BuildContext context) {

    final updateWarehouse = ModalRoute.of(context)!.settings.arguments as WarehouseModel;
    //companyId.text = updateWarehouse.companyId!;
    warehouseName.text = updateWarehouse.warehouseName!;
    selectedValue = getCompanyName(updateWarehouse.companyId!);
    recordId = updateWarehouse.warehouseId!;
    return Scaffold(
      appBar: appbar(context, 'Update Warehouse', {'icons' : Icons.menu}),
      body: Container(
          child: Padding(
            padding: const EdgeInsets.all(constants.bodyPadding),
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
                  popupProps: PopupProps.modalBottomSheet(
                    showSelectedItems: true,
                    disabledItemFn: (String s) => s.startsWith('I'),
                  ),
                  items: companyData.values.toList(),
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      labelText: "Company",
                      hintText: "Select Company",
                    ),
                  ),
                  onChanged: (val){
                    var key = companyData.keys.firstWhere((k)
                    => companyData[k] == val!, orElse: () => "");
                    companyId.text = key!;
                    setState(() {
                      selectedValue = val!;
                    });
                    print(companyId.text);
                  },
                  selectedItem: selectedValue,
                ),
                Container(height: 20),


                SizedBox(
                  width: constants.buttonWidth,
                  height: constants.buttonHeight,
                  child: ElevatedButton(onPressed: (){
                    String uCompanyId = companyId.text.toString();
                    String uWarehouseName = warehouseName.text;

                    if(uCompanyId == ''){
                      uCompanyId = updateWarehouse.companyId.toString();
                    }

                    dbHelper!.updateWarehouse(
                        WarehouseModel(
                          warehouseId: recordId,
                      companyId: uCompanyId,
                          warehouseName: uWarehouseName,
                        )
                    ).then((value) {
                      constants.Notification("Warehouse Updated Successfully");
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => Warehouse()));
                      Navigator.pop(context,value);
                    }).onError((error, stackTrace) {
                      print(error.toString());
                    });
                  }, child: Text(
                      'Save'
                      ,style: TextStyle(color: Colors.white,fontSize: 16)),
                      style: ElevatedButton.styleFrom(
                        primary: constants.mainColor, //background color of button
                        shape: RoundedRectangleBorder( //to set border radius to button
                            borderRadius: BorderRadius.circular(10)
                        ),
                      )
                  ),
                )
              ],
            ),
          )),
    );
  }
}