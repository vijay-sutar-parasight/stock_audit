import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/audit/audit.dart';
import 'package:stock_audit/auditentries/updateauditentries.dart';
import 'package:stock_audit/util/constants.dart' as constants;
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/auditentriesmodel.dart';
import '../models/auditmodel.dart';
import 'addauditentries.dart';
import 'auditentries_handler.dart';




class AuditEntries extends StatefulWidget{
  @override
  String auditCompanyId;
  AuditEntries({required this.auditCompanyId});
  State<AuditEntries> createState() => AuditEntriesList(auditCompanyId);
}

class AuditEntriesList extends State<AuditEntries> {

  String auditCompanyId;
  AuditEntriesList(this.auditCompanyId);

  AuditentriesDBHelper? dbHelper;
  late Future<List<AuditEntriesModel>> auditEntriesList;

  void initState(){
    super.initState();
    dbHelper = AuditentriesDBHelper();
    loadData(auditCompanyId);

  }

  loadData (companyId) async{
    auditEntriesList = dbHelper!.getAuditEntriesList(companyId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Audit Entries')
      ),
      body: Column(
        children: [
          // if (apiList != null)
          // getList(),
          Expanded(
            child: FutureBuilder(
              future: auditEntriesList,
                builder: (context, AsyncSnapshot<List<AuditEntriesModel>> snapshot){
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
                                dbHelper!.delete(snapshot.data![index].entryId!);
                                auditEntriesList = dbHelper!.getAuditEntriesList(auditCompanyId);
                                snapshot.data!.remove(snapshot.data![index]);
                              });
                            },
                            key: ValueKey<int>(snapshot.data![index].entryId!),
                            child: Card(
                              child: ListTile(
                                contentPadding: EdgeInsets.all(0),
                                title: Text(snapshot.data![index].productName.toString()),
                                subtitle: Text(snapshot.data![index].brandName.toString()),
                                trailing: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>  UpdateAuditEntries(selectedCompanyId: auditCompanyId.toString()),
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

                              ),
                            ),
                          ),
                        );
                      });
                }else{
                  return Center(child: CircularProgressIndicator(

                  ));
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddAuditEntries(selectedCompanyId: auditCompanyId.toString()),));
            },
            tooltip: 'Add Audit Entries',
            child: const Icon(Icons.add, color: Colors.white,),
            backgroundColor: Colors.lightBlue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50.0))
            ),
          ),
        )
    );
  }
}