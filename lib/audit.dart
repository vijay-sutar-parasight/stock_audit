import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/addaudit.dart';
import 'package:stock_audit/util/constants.dart' as constants;
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'GetAuditData.dart';
import 'auditentries.dart';
import 'db_handler.dart';
import 'models/auditmodel.dart';


class Audit extends StatefulWidget{
  @override
  State<Audit> createState() => AuditList();
}

class AuditList extends State<Audit> {

  DBHelper? dbHelper;
  late Future<List<AuditModel>> auditList;
  List<GetAuditData>? apiList;

  void initState(){
    super.initState();
    getApiData();
    dbHelper = DBHelper();
    loadData();
  }

  loadData () async{
    auditList = dbHelper!.getAuditList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Audit')
      ),
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
                                dbHelper!.delete(snapshot.data![index].id!);
                                auditList = dbHelper!.getAuditList();
                                snapshot.data!.remove(snapshot.data![index]);
                              });
                            },
                            key: ValueKey<int>(snapshot.data![index].id!),
                            child: Card(
                              child: ListTile(
                                contentPadding: EdgeInsets.all(0),
                                title: Text(snapshot.data![index].title.toString()),
                                subtitle: Text(snapshot.data![index].description.toString()),
                                trailing: Icon(Icons.edit),

                              ),
                            ),
                          ),
                        );
                      });
                }else{
                  return CircularProgressIndicator();
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
            backgroundColor: Colors.lightBlue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50.0))
            ),
          ),
        )
    );
  }

  Widget getList(){
    return Expanded(
      child: ListView.builder(
          itemCount: apiList!.length,
          itemBuilder: (BuildContext, int index)
          {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                    elevation: 5,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(5, 10, 0, 10),
                      child: Column(
                        children: [
                          Text("${apiList![index].auditDiscription}"),
                          InkWell(
                              onTap: (){
                               // Navigator.push(context, MaterialPageRoute(builder: (context) => AuditEntries()), {apiList![index].auditId);
                              },
                              child: Icon(Icons.add)),
                        ],
                      ),

                    )
                )
              ],
            );
          }),
    );
  }


  Future<void> getApiData() async{
    String url = "${constants.apiBaseURL}/audit";
    var result = await http.get(Uri.parse(url));
    //print(result.body);
    apiList = jsonDecode(result.body)
        .map((item) => GetAuditData.fromJson(item))
        .toList()
        .cast<GetAuditData>();

    // setState(() {
    //
    // });
  }
}