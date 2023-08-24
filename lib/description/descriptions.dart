import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/util/constants.dart' as constants;
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../GetDescriptionData.dart';

class Descriptions extends StatefulWidget{
  @override
  State<Descriptions> createState() => DescriptionList();
}

class DescriptionList extends State<Descriptions> {
  List<GetDescriptionData>? apiList;

  void initState(){
    super.initState();
    getApiData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Descriptions')
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
                      child: Text("${apiList![index].productName}"),
                    )
                )
              ],
            );
          }),
    );
  }


  Future<void> getApiData() async{
    String url = "${constants.apiBaseURL}/product";
    var result = await http.get(Uri.parse(url));
    //print(result.body);
    apiList = jsonDecode(result.body)
        .map((item) => GetDescriptionData.fromJson(item))
        .toList()
        .cast<GetDescriptionData>();

    setState(() {

    });
  }
}