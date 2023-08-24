import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/util/constants.dart' as constants;
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../GetAuditData.dart';
import '../models/auditentriesmodel.dart';
import 'addauditentries.dart';
import 'auditentries_handler.dart';




class AuditEntries extends StatefulWidget{
  @override
  State<AuditEntries> createState() => AuditEntriesList();
}

class AuditEntriesList extends State<AuditEntries> {

  AuditentriesDBHelper? dbHelper;
  late Future<List<AuditEntriesModel>> auditEntriesList;
  List<GetAuditData>? apiList;

  void initState(){
    super.initState();
    getApiData();
    dbHelper = AuditentriesDBHelper();
    loadData();
  }

  loadData () async{
    auditEntriesList = dbHelper!.getAuditEntriesList();
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
                                auditEntriesList = dbHelper!.getAuditEntriesList();
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
                                        builder: (context) =>  AddAuditEntries(),
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddAuditEntries()));
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