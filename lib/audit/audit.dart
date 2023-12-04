import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/audit/addaudit.dart';
import 'package:stock_audit/audit/updateaudit.dart';
import 'package:stock_audit/util/constants.dart' as constants;
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../appbar.dart';
import '../auditentries/addauditentries.dart';
import '../auditentries/auditentries.dart';
import '../db_handler.dart';
import '../jsondata/GetCompanyData.dart';
import '../models/auditmodel.dart';

class Audit extends StatefulWidget{
  @override
  State<Audit> createState() => AuditList();
}

class AuditList extends State<Audit> {

  DBHelper? dbHelper;
  late Future<List<AuditModel>> auditList;
  List<GetCompanyData> _companyMasterList = [];

  String selectedValue = "";
  Map<int, String> companyData = {};

  void initState(){
    super.initState();
    dbHelper = DBHelper();
    loadData();
    getCompanyData();
  }

  loadData () async{
    auditList = dbHelper!.getAuditList();
  }

  Future<void> getCompanyData() async {
    _companyMasterList = await dbHelper!.getCompanyListArray();
    for (int i = 0; i < _companyMasterList.length; i++) {
      companyData[_companyMasterList[i].companyId!] = _companyMasterList[i].companyName!;
    }
  }

  getCompanyName(companyId){
    var companyName = "";
    if(companyId != ''){
     // print(companyId);
      companyName = companyData[int.parse(companyId)].toString();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context, 'Audit', {'icons' : Icons.menu}),
      body: Column(
        children: [
          // if (apiList != null)
          // getList(),
          Expanded(
            child: FutureBuilder(
              future: auditList,
                builder: (context, AsyncSnapshot<List<AuditModel>> snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                      itemCount: snapshot.data?.length,
                      reverse: false,
                      shrinkWrap: true,
                      itemBuilder: (context, index){
                        return InkWell(
                          child: Dismissible(
                            direction: DismissDirection.endToStart,
                            background: Container(
                              color: Colors.red,
                              child: Icon(Icons.delete_forever),
                            ),
                            onDismissed: (DismissDirection){
                              setState(() {
                                dbHelper!.delete(snapshot.data![index].auditId!);
                                auditList = dbHelper!.getAuditList();
                                snapshot.data!.remove(snapshot.data![index]);
                              });
                            },
                            key: ValueKey<int>(snapshot.data![index]!.auditId!),
                            child: Card(
                              child: ListTile(
                                contentPadding: EdgeInsets.all(6),
                                iconColor: constants.mainColor,
                                titleTextStyle: TextStyle(color:constants.mainColor,fontSize: 16,fontWeight: FontWeight.bold),
                                tileColor: Colors.white,
                                title: Text("Company: "+getCompanyName(snapshot.data![index].companyId)),
                                subtitle: Text("Status: "+getStatus(snapshot.data![index].auditStatus.toString())),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>  UpdateAudit(),
                                            // Pass the arguments as part of the RouteSettings. The
                                            // UpdateScreen reads the arguments from these settings.
                                            settings: RouteSettings(
                                              arguments: snapshot.data![index],
                                            ),
                                          ),
                                        );
                                      },
                                        child: Icon(Icons.edit)
                                    ),
                                    SizedBox(height: 6,),
                                    InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>  AuditEntries(auditCompanyId: snapshot.data![index].companyId.toString()),
                                              // Pass the arguments as part of the RouteSettings. The
                                              // UpdateScreen reads the arguments from these settings.
                                              settings: RouteSettings(
                                                arguments: snapshot.data![index],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Icon(Icons.add)
                                    ),

                              ],
                                ),

                              ),
                            ),
                          ),
                        );
                      });
                }else{
                  return Center(child: CircularProgressIndicator());
                }

                }),
          )
        ],
      ),
        floatingActionButton: SizedBox(
          width: 70,
            height: 70,
          child: FloatingActionButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddAudit()));
            },
            tooltip: 'Add Audit',
            child: const Icon(Icons.add, color: Colors.white,),
            backgroundColor: constants.mainColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50.0))
            ),
          ),
        )
    );
  }
}