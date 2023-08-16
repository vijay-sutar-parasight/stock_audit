import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/util/constants.dart' as constants;
import 'package:http/http.dart' as http;

import 'GetBrandData.dart';

class Brands extends StatefulWidget{
  @override
  State<Brands> createState() => BrandList();
}

class BrandList extends State<Brands>{

  List<GetBrandData>? apiList;

  void initState(){
    super.initState();
    getApiData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brands')
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
             child: Text("${apiList![index].brandName}"),
           )
         )
       ],
     );
    }),
    );
  }


  Future<void> getApiData() async{
    String url = "${constants.apiBaseURL}/brand";
    var result = await http.get(Uri.parse(url));
    apiList = jsonDecode(result.body)
    .map((item) => GetBrandData.fromJson(item))
    .toList()
    .cast<GetBrandData>();

    setState(() {

    });
  }

}