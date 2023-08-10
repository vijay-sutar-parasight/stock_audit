import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/addaudit.dart';
import 'package:stock_audit/util/constants.dart' as constants;


class AuditEntries extends StatefulWidget{
  @override
  State<AuditEntries> createState() => AuditEntriesList();
}

class AuditEntriesList extends State<AuditEntries> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Audit Entries')
      ),
      body: getAuditList(),
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

  ListView getAuditList() {
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