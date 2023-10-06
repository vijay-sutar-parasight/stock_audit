import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stock_audit/brand/brands.dart';
import 'package:stock_audit/company/company.dart';
import 'package:stock_audit/jsondata/GetCompanyData.dart';
import 'package:stock_audit/models/brandmodel.dart';
import 'package:stock_audit/util/constants.dart' as constants;

import '../../db_handler.dart';
import '../appbar.dart';
import '../models/companymodel.dart';

class AddBrand extends StatefulWidget{
  @override
  State<AddBrand> createState() => _AddBrand();
}

class _AddBrand extends State<AddBrand>{
  var brandId = TextEditingController();
  var companyId = TextEditingController();
  var brandName = TextEditingController();

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
      appBar: appbar(context, 'Add Brand', {'icons' : Icons.menu}),
      body: Container(

          child: Padding(
            padding: const EdgeInsets.all(constants.bodyPadding),
            child: Column(
              children: [
                TextField(
                    controller: brandName,
                    decoration: InputDecoration(
                        hintText: 'Brand Name',
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
                    //disabledItemFn: (String s) => s.startsWith('I'),
                  ),
                  // items: _CompanyList,
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
                    String uCompany = companyId.text.toString();
                    String uBrandName = brandName.text;
                    dbHelper!.insertBrand(
                        BrandModel(
                      companyId: uCompany,
                      brandName: uBrandName
                        )
                    ).then((value) {
                      constants.Notification("Brand Added Successfully");
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => Brands()));
                      Navigator.pop(context,true);
                      //Navigator.(context, MaterialPageRoute(builder: (context) => Brands()));
                      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Brands()));
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