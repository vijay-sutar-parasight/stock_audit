import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/brand/brands.dart';
import 'package:stock_audit/company/company.dart';
import 'package:stock_audit/jsondata/GetCompanyData.dart';
import 'package:stock_audit/models/brandmodel.dart';
import 'package:stock_audit/util/constants.dart' as constants;

import '../../db_handler.dart';
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

  DBHelper? dbHelper;

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Brand')
      ),
      body: Container(

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
                selectedItem: "",
              ),
              Container(height: 11),
              // TextField(
              //   controller: companyId,
              //   decoration: InputDecoration(
              //       hintText: 'Select Company',
              //       focusedBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(11),
              //           borderSide: BorderSide(
              //               color: Colors.deepOrange,
              //               width: 2
              //           )
              //       ),
              //       enabledBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(11),
              //           borderSide: BorderSide(
              //               color: Colors.blueAccent,
              //               width: 2
              //           )
              //       ),
              //       prefixIcon: Icon(Icons.add_business, color: Colors.orange)
              //   ),
              // ),
              Container(height: 20),
              ElevatedButton(onPressed: (){
                String uCompany = companyId.text.toString();
                String uBrandName = brandName.text;
                dbHelper!.insertBrand(
                    BrandModel(
                  companyId: uCompany,
                  brandName: uBrandName
                    )
                ).then((value) {
                  print('Data added Successfully');
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Brands()));
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