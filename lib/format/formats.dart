import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/util/constants.dart' as constants;
import 'package:http/http.dart' as http;

import '../GetFormatData.dart';

class Formats extends StatefulWidget {
  @override
  State<Formats> createState() => FormatsList();
}
  class FormatsList extends State<Formats> {
    List<GetFormatData>? apiList;

    void initState(){
      super.initState();
      getApiData();
    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
            title: Text('Formats')
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
                        child: Text("${apiList![index].formatName}"),
                      )
                  )
                ],
              );
            }),
      );
    }


    Future<void> getApiData() async{
      String url = "${constants.apiBaseURL}/format";
      var result = await http.get(Uri.parse(url));
      apiList = jsonDecode(result.body)
          .map((item) => GetFormatData.fromJson(item))
          .toList()
          .cast<GetFormatData>();

      setState(() {

      });
    }
  }