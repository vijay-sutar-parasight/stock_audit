import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/util/constants.dart' as constants;

import '../../db_handler.dart';
import '../../models/auditmodel.dart';
import '../appbar.dart';
import '../jsondata/GetCompanyData.dart';
import 'audit.dart';

class AddAudit extends StatefulWidget{
  @override
  State<AddAudit> createState() => _AddAudit();
}

class _AddAudit extends State<AddAudit>{
  var companyId = TextEditingController();
  var auditDescription = TextEditingController();
  var auditStatus = TextEditingController();

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

  List<String> statusDropdown = ['Active','Inactive'];
  String selectedItem = 'Active';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context, 'Add Audit', {'icons' : Icons.menu}),
      body: Container(

          child: Column(
            children: [
              DropdownSearch<String>(
                popupProps: PopupProps.modalBottomSheet(
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
              TextField(
                  controller: auditDescription,
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
              Container(height: 20),
              DropdownSearch<String>(
                popupProps: PopupProps.modalBottomSheet(
                  showSelectedItems: true,
                  disabledItemFn: (String s) => s.startsWith('I'),
                ),
                items: statusDropdown,
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Status",
                    hintText: "Select Status",
                  ),
                ),
                onChanged: (val){

                  auditStatus.text = val!;
                },
                selectedItem: "",
              ),
              Container(height: 20),
              ElevatedButton(onPressed: (){
                String uCompany = companyId.text.toString();
                String uDescription = auditDescription.text;
                String uStatus = auditStatus.text;
                dbHelper!.insert(
                    AuditModel(
                  companyId: uCompany,
                  auditDescription: uDescription,
                      auditStatus: uStatus,
                    )
                ).then((value) {
                  constants.Notification("Audit Added Successfully");
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => Audit()));
                  Navigator.pop(context,value);
                }).onError((error, stackTrace) {
                  print(error.toString());
                });
                print("Company: $uCompany, Description: $uDescription, Status: $uStatus");
              }, child: Text(
                  'Save'
              ))
            ],
          )),
    );
  }
}