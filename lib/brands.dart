import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/util/constants.dart' as constants;
import 'package:http/http.dart' as http;

class Brands extends StatefulWidget{
  @override
  State<Brands> createState() => BrandList();
}

class BrandList extends State<Brands>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brands')
      ),
      body: getBrandsList(),
    );
  }

  Future<ListView> getBrandsList() async {

    String url = "${constants.apiBaseURL}/brand";
    var results = await http.get(Uri.parse(url));
    var arrNames = jsonDecode(results.body);
    return ListView.separated(itemBuilder: (context, index){
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(arrNames[index].brand_name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
      );
    },
    itemCount: arrNames.length,
      separatorBuilder: (BuildContext context, int index) {
      return Divider(height: 30, thickness: 2,);
      },
    );

  }

}