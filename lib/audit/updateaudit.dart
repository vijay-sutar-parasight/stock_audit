import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stock_audit/util/constants.dart' as constants;

import '../appbar.dart';
import '../db_handler.dart';
import '../jsondata/GetCompanyData.dart';
import '../models/auditmodel.dart';
import 'audit.dart';

class UpdateAudit extends StatefulWidget{
  @override
  State<UpdateAudit> createState() => _UpdateAudit();
}

class _UpdateAudit extends State<UpdateAudit>{
  var companyId = TextEditingController();
  var auditDescription = TextEditingController();
  var auditStatus = TextEditingController();
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

  getStatus(auditStatus){
    var status = "";
    if(auditStatus == '1'){
      status = 'Active';
    }else{
      status = "Inactive";
    }
    return status;
  }

  List<String> statusDropdown = ['Active','Inactive'];
  String selectedItem = 'Active';
  @override
  Widget build(BuildContext context) {

    final updateAudit = ModalRoute.of(context)!.settings.arguments as AuditModel;
    //companyId.text = updateAudit.companyId ?? "";
    auditDescription.text = updateAudit.auditDescription ?? "";
    auditStatus.text = updateAudit.auditStatus ?? "";
    selectedValue = getCompanyName(updateAudit.companyId!);
    selectedItem = getStatus(updateAudit.auditStatus ?? "");
    recordId = updateAudit.auditId!;
    return Scaffold(
      appBar: appbar(context, 'Update Audit', {'icons' : Icons.menu}),
      body: Container(
          child: Padding(
            padding: const EdgeInsets.all(constants.bodyPadding),
            child: Column(
              children: [
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
                  },
                  selectedItem: selectedValue,
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
                    //disabledItemFn: (String s) => s.startsWith('I'),
                  ),
                  items: statusDropdown,
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      labelText: "Status",
                      hintText: "Select Status",
                    ),
                  ),
                  onChanged: (val){
                    var status = 0;
                    if(val == 'Active'){
                      status = 1;
                    }
                    auditStatus.text = status.toString();
                  },
                  selectedItem: selectedItem,
                ),
                Container(height: 20),
                SizedBox(
                  width: constants.buttonWidth,
                  height: constants.buttonHeight,
                  child: ElevatedButton(onPressed: (){
                    String uCompany = companyId.text.toString();
                    String uDescription = auditDescription.text;
                    String uStatus = auditStatus.text;

                    if(uCompany == ''){
                      uCompany = updateAudit.companyId.toString();
                    }

                    dbHelper!.update(
                        AuditModel(
                          auditId: recordId,
                      companyId: uCompany,
                          auditDescription: uDescription,
                      auditStatus: uStatus,
                        )
                    ).then((value) {
                      constants.Notification("Audit Updated Successfully");
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => Audit()));
                      Navigator.pop(context,value);
                    }).onError((error, stackTrace) {
                      print(error.toString());
                    });
                    print("Company: $uCompany, Description: $uDescription, Status: $uStatus");
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