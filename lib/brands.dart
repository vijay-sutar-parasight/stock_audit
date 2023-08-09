import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Brands extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return BrandList();
  }
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

  ListView getBrandsList(){
    var arrNames = ['Vijay','Deepali','Mahesh','Deepti'];
    return ListView.separated(itemBuilder: (context, index){
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(arrNames[index], style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
      );
    },
    itemCount: arrNames.length,
      separatorBuilder: (BuildContext context, int index) {
      return Divider(height: 30, thickness: 2,);
      },
    );

  }

}