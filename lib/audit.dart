import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/addaudit.dart';
import 'package:stock_audit/util/constants.dart' as constants;
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'GetAuditData.dart';
import 'auditentries.dart';


class Audit extends StatefulWidget{
  @override
  State<Audit> createState() => AuditList();
}

class AuditList extends State<Audit> {

  List<GetAuditData>? apiList;

  void initState(){
    super.initState();
    getApiData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Audit')
      ),
      body: Column(
        children: [
          if (apiList != null)
          getList(),
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
                                Navigator.push(context, MaterialPageRoute(builder: (context) => AuditEntries()), {apiList![index].auditId);
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

    setState(() {

    });
  }
}