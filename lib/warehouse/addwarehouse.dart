import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/util/constants.dart' as constants;
import 'package:stock_audit/variant/variants.dart';
import 'package:stock_audit/warehouse/warehouse.dart';

import '../../db_handler.dart';
import '../appbar.dart';
import '../jsondata/GetCompanyData.dart';
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

  List<String> _CompanyList = [];
  List<GetCompanyData> _companyMasterList = [];

  String selectedValue = "";
  Map<String, String> companyData = {};

  DBHelper? dbHelper;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context, 'Add Warehouse', {'icons' : Icons.menu}),
      body: Container(

          child: Padding(
            padding: const EdgeInsets.all(constants.bodyPadding),
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
                  selectedItem: "",
                ),

                Container(height: 20),
                SizedBox(
                  width: constants.buttonWidth,
                  height: constants.buttonHeight,
                  child: ElevatedButton(onPressed: (){
                    String uCompanyId = companyId.text.toString();
                    String uWarehouseName = warehouseName.text;
                    dbHelper!.insertWarehouse(
                        WarehouseModel(
                            companyId: uCompanyId,
                      warehouseName: uWarehouseName
                        )
                    ).then((value) {
                      constants.Notification("Warehouse Added Successfully");
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