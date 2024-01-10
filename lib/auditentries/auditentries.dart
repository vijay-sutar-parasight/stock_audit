import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/audit/audit.dart';
import 'package:stock_audit/auditentries/updateauditentries.dart';
import 'package:stock_audit/util/constants.dart' as constants;
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../appbar.dart';
import '../models/auditentriesmodel.dart';
import '../models/auditmodel.dart';
import 'addauditentries.dart';
import 'auditentries_handler.dart';




class AuditEntries extends StatefulWidget{
  @override
  String auditCompanyId;
  String auditId;
  AuditEntries({required this.auditCompanyId,required this.auditId});
  State<AuditEntries> createState() => AuditEntriesList(auditCompanyId,auditId);
}

class AuditEntriesList extends State<AuditEntries> {

  String auditCompanyId;
  String auditId;
  AuditEntriesList(this.auditCompanyId, this.auditId);

  AuditentriesDBHelper? dbHelper;
  late Future<List<AuditEntriesModel>> auditEntriesList;

  void initState(){
    super.initState();
    dbHelper = AuditentriesDBHelper();
    loadData(auditCompanyId, auditId);

  }

  loadData (companyId, auditId) async{
    auditEntriesList = dbHelper!.getAuditEntriesList(companyId,auditId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context, 'Audit Entries', {'icons' : Icons.menu}),
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
                                auditEntriesList = dbHelper!.getAuditEntriesList(auditCompanyId,auditId);
                                snapshot.data!.remove(snapshot.data![index]);
                              });
                            },
                            key: ValueKey<int>(snapshot.data![index].entryId!),
                            child: Card(
                              child: ListTile(
                                contentPadding: EdgeInsets.all(6),
                                iconColor: constants.mainColor,
                                titleTextStyle: TextStyle(color:constants.mainColor,fontSize: 16,fontWeight: FontWeight.bold),
                                tileColor: Colors.white,
                                title: Text(snapshot.data![index].productName.toString()),
                                subtitle: Text(snapshot.data![index].brandName.toString()),
                                trailing: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>  UpdateAuditEntries(selectedCompanyId: auditCompanyId.toString(),selectedAuditId: auditId),
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddAuditEntries(selectedCompanyId: auditCompanyId.toString(), selectedAuditId: auditId.toString()),));
            },
            tooltip: 'Add Audit Entries',
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