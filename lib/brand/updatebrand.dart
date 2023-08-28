import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/brand/brands.dart';
import 'package:stock_audit/jsondata/GetCompanyData.dart';
import 'package:stock_audit/util/constants.dart' as constants;

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

    final updateAudit = ModalRoute.of(context)!.settings.arguments as BrandModel;
    companyId.text = updateAudit.companyId!;
    brandName.text = updateAudit.brandName!;
    recordId = updateAudit.brandId!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Audit')
      ),
      body: Container(
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
                String uCompany = companyId.text.toString();
                String uBrandName = brandName.text;
                dbHelper!.updateBrand(
                    BrandModel(
                      brandId: recordId,
                  companyId: uCompany,
                      brandName: uBrandName,
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