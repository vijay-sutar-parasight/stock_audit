import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/util/constants.dart' as constants;
import 'package:http/http.dart' as http;

import 'GetAuditEntriesData.dart';


class AuditEntries extends StatefulWidget{
  @override
  State<AuditEntries> createState() => AuditEntriesList();
}

class AuditEntriesList extends State<AuditEntries>{

  List<GetAuditEntriesData>? apiList;

  void initState(){
    super.initState();
    getApiData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audit Entries')
      ),
      body: Column(
        children: [
          if (apiList != null)
          getList()
        ],
      ),
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
             child: Text("${apiList![index].auditDiscription}"),
           )
         )
       ],
     );
    }),
    );
  }


  Future<void> getApiData() async{
    String url = "${constants.apiBaseURL}/entries/";
    var result = await http.get(Uri.parse(url));
    apiList = jsonDecode(result.body)
    .map((item) => GetAuditEntriesData.fromJson(item))
    .toList()
    .cast<GetAuditEntriesData>();

    setState(() {

    });
  }

}