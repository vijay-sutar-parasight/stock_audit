import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/util/constants.dart' as constants;

class Formats extends StatefulWidget {
  @override
  State<Formats> createState() => FormatsList();
}
  class FormatsList extends State<Formats> {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
            title: Text('Formats')
        ),
        body: getFormatsList(),
      );
    }

    ListView getFormatsList() {
      String url = constants.apiBaseURL;
      var arrNames = ['Vijay', 'Deepali', 'Mahesh', 'Deepti'];
      return ListView.separated(itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(arrNames[index],
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
        );
      },
        itemCount: arrNames.length,
        separatorBuilder: (BuildContext context, int index) {
          return Divider(height: 30, thickness: 2,);
        },
      );
    }
  }