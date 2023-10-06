import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stock_audit/brand/brands.dart';
import 'package:stock_audit/jsondata/GetCompanyData.dart';
import 'package:stock_audit/util/constants.dart' as constants;

import '../appbar.dart';
import '../audit/audit.dart';
import '../db_handler.dart';
import '../models/auditmodel.dart';
import '../models/brandmodel.dart';
import '../models/companymodel.dart';

class UpdateBrand extends StatefulWidget{
  @override
  State<UpdateBrand> createState() => _UpdateBrand();
}

class _UpdateBrand extends State<UpdateBrand>{
  var companyId = TextEditingController();
  var brandName = TextEditingController();
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

    final updateBrand = ModalRoute.of(context)!.settings.arguments as BrandModel;
    //companyId.text = updateBrand.companyId!;
    brandName.text = updateBrand.brandName!;
    selectedValue = getCompanyName(updateBrand.companyId!);
    recordId = updateBrand.brandId!;
    return Scaffold(
      appBar: appbar(context, 'Update Brand', {'icons' : Icons.menu}),
      body: Container(
          child: Padding(
            padding: const EdgeInsets.all(constants.bodyPadding),
            child: Column(
              children: [
                Container(height: 11),
                TextField(
                    controller: brandName,
                    decoration: InputDecoration(
                        hintText: 'Short Description',
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
                    String uCompany = companyId.text.toString();
                    if(uCompany == ''){
                      uCompany = updateBrand.companyId.toString();
                    }
                    print("changed company id is $uCompany");
                    String uBrandName = brandName.text;
                    dbHelper!.updateBrand(
                        BrandModel(
                          brandId: recordId,
                      companyId: uCompany,
                          brandName: uBrandName,
                        )
                    ).then((value) {
                      constants.Notification("Brand Updated Successfully");
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => Brands()));
                      Navigator.pop(context,value);
                    }).onError((error, stackTrace) {
                      print(error.toString());
                    });
                  }, child: Text(
                      'Save',style: TextStyle(color: Colors.white,fontSize: 16)),
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