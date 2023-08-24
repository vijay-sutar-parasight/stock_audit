import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/util/constants.dart' as constants;
import 'package:http/http.dart' as http;

import '../GetWarehouseData.dart';

class Warehouse extends StatefulWidget {
  @override
  State<Warehouse> createState() => WarehouseList();
}
  class WarehouseList extends State<Warehouse> {
    List<GetWarehouseData>? apiList;

    void initState(){
      super.initState();
      getApiData();
    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
            title: Text('Warehouse')
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
                        child: Text("${apiList![index].warehouseName}"),
                      )
                  )
                ],
              );
            }),
      );
    }


    Future<void> getApiData() async{
      String url = "${constants.apiBaseURL}/warehouse";
      var result = await http.get(Uri.parse(url));
      //print(result.body);
      apiList = jsonDecode(result.body)
          .map((item) => GetWarehouseData.fromJson(item))
          .toList()
          .cast<GetWarehouseData>();

      setState(() {

      });
    }
  }