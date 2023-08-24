import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/util/constants.dart' as constants;
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../GetVariantData.dart';

class Variants extends StatefulWidget{
  @override
  State<Variants> createState() => VariantList();
}

class VariantList extends State<Variants> {
  List<GetVariantData>? apiList;

  void initState(){
    super.initState();
    getApiData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Variants')
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
                      child: Text("${apiList![index].variantName}"),
                    )
                )
              ],
            );
          }),
    );
  }


  Future<void> getApiData() async{
    String url = "${constants.apiBaseURL}/variant";
    var result = await http.get(Uri.parse(url));
    //print(result.body);
    apiList = jsonDecode(result.body)
        .map((item) => GetVariantData.fromJson(item))
        .toList()
        .cast<GetVariantData>();

    setState(() {

    });
  }
}