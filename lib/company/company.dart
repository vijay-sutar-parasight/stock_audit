import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/company/updatecompany.dart';
import 'package:stock_audit/util/constants.dart' as constants;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stock_audit/variant/updatevariant.dart';

import '../appbar.dart';
import '../db_handler.dart';
import '../models/companymodel.dart';
import '../models/variantmodel.dart';
import 'addcompany.dart';

class Company extends StatefulWidget{
  @override
  State<Company> createState() => CompanyList();
}

class CompanyList extends State<Company> {
  DBHelper? dbHelper;
  late Future<List<CompanyModel>> companyList;

  @override
  void initState(){
    super.initState();
    dbHelper = DBHelper();
    loadData();
  }

  loadData () async{
    companyList = dbHelper!.getCompanyList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar(context, 'Company', {'icons' : Icons.menu}),
        body: Column(
          children: [
            // if (apiList != null)
            // getList(),
            Expanded(
              child: FutureBuilder(
                  future: companyList,
                  builder: (context, AsyncSnapshot<List<CompanyModel>> snapshot){
                    if(snapshot.hasData){
                      return ListView.builder(
                          itemCount: snapshot.data?.length,
                          reverse: false,
                          shrinkWrap: true,
                          itemBuilder: (context, index){
                            return InkWell(
                              child: Dismissible(
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  color: Colors.red,
                                  child: Icon(Icons.delete_forever),
                                ),
                                onDismissed: (DismissDirection){
                                  setState(() {
                                    dbHelper!.deleteVariant(snapshot.data![index].companyId!);
                                    companyList = dbHelper!.getCompanyList();
                                    snapshot.data!.remove(snapshot.data![index]);
                                  });
                                },
                                key: ValueKey<int>(snapshot.data![index]!.companyId!),
                                child: Card(
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(0),
                                    title: Text(snapshot.data![index].companyName.toString()),
                                    subtitle: Text(snapshot.data![index].companyAddress.toString()),
                                    trailing: Column(
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>  UpdateCompany(),
                                                  // Pass the arguments as part of the RouteSettings. The
                                                  // UpdateScreen reads the arguments from these settings.
                                                  settings: RouteSettings(
                                                    arguments: snapshot.data![index],
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Icon(Icons.edit)
                                        ),
                                      ],
                                    ),

                                  ),
                                ),
                              ),
                            );
                          });
                    }else{
                      return Center(child: CircularProgressIndicator());
                    }

                  }),
            )
          ],
        ),
        floatingActionButton: SizedBox(
          width: 70,
          height: 70,
          child: FloatingActionButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddCompany()));
            },
            tooltip: 'Add Company',
            child: const Icon(Icons.add, color: Colors.white,),
            backgroundColor: Colors.lightBlue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50.0))
            ),
          ),
        )
    );
  }

}