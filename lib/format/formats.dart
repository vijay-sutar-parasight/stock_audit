import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/format/updateformat.dart';
import 'package:stock_audit/util/constants.dart' as constants;
import 'package:http/http.dart' as http;

import '../GetFormatData.dart';
import '../db_handler.dart';
import '../models/formatmodel.dart';
import 'addformat.dart';

class Formats extends StatefulWidget {
  @override
  State<Formats> createState() => FormatsList();
}
  class FormatsList extends State<Formats> {

    DBHelper? dbHelper;
    late Future<List<FormatModel>> formatList;

    void initState(){
      super.initState();
      dbHelper = DBHelper();
      loadData();
    }

    loadData () async{
      formatList = dbHelper!.getFormatList();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
              title: Text('Formats')
          ),
          body: Column(
            children: [
              // if (apiList != null)
              // getList(),
              Expanded(
                child: FutureBuilder(
                    future: formatList,
                    builder: (context, AsyncSnapshot<List<FormatModel>> snapshot){
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
                                      dbHelper!.deleteFormat(snapshot.data![index].formatId!);
                                      formatList = dbHelper!.getFormatList();
                                      snapshot.data!.remove(snapshot.data![index]);
                                    });
                                  },
                                  key: ValueKey<int>(snapshot.data![index]!.formatId!),
                                  child: Card(
                                    child: ListTile(
                                      contentPadding: EdgeInsets.all(0),
                                      title: Text(snapshot.data![index].brandId.toString()),
                                      subtitle: Text(snapshot.data![index].formatName.toString()),
                                      trailing: Column(
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>  UpdateFormat(),
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddFormat()));
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

  }