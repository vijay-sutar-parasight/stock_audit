import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/util/constants.dart' as constants;

import 'audit.dart';
import 'db_handler.dart';
import 'models/auditmodel.dart';

class UpdateAudit extends StatefulWidget{
  @override
  State<UpdateAudit> createState() => _UpdateAudit();
}

class _UpdateAudit extends State<UpdateAudit>{
  var company = TextEditingController();
  var shortDescription = TextEditingController();
  var status = TextEditingController();
  var recordId;

  DBHelper? dbHelper;

  @override
  void initState(){
    super.initState();
    dbHelper = DBHelper();
  }

  List statusDropdown = ['Active','Inactive'];
  String selectedItem = 'Active';
  @override
  Widget build(BuildContext context) {

    final updateAudit = ModalRoute.of(context)!.settings.arguments as AuditModel;
    company.text = updateAudit.title!;
    shortDescription.text = updateAudit.description!;
    recordId = updateAudit.id!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Audit')
      ),
      body: Container(
          child: Column(
            children: [
              TextField(
                controller: company,
                decoration: InputDecoration(
                    hintText: 'Select Company',
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
                  controller: shortDescription,
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
              DropdownButton(
                  value: selectedItem, items: statusDropdown.map((e) {
                return DropdownMenuItem(value: e,child: Text(e));
              }).toList(), onChanged: (val){
                setState(() {
                  selectedItem = val as String;
                });
              }),
              Container(height: 20),
              ElevatedButton(onPressed: (){
                String uCompany = company.text.toString();
                String uDescription = shortDescription.text;
                String uStatus = status.text;
                dbHelper!.update(
                    AuditModel(
                      id: recordId,
                  title: uCompany,
                  description: uDescription,
                    )
                ).then((value) {
                  print('Data added Successfully');
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Audit()));
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