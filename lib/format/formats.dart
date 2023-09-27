import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/format/updateformat.dart';
import 'package:stock_audit/jsondata/GetBrandData.dart';
import 'package:stock_audit/jsondata/GetFormatData.dart';
import 'package:stock_audit/util/constants.dart' as constants;
import 'package:http/http.dart' as http;

import '../appbar.dart';
import '../db_handler.dart';
import '../models/formatmodel.dart';
import 'addformat.dart';

class Formats extends StatefulWidget {
  @override
  State<Formats> createState() => FormatsList();
}
  class FormatsList extends State<Formats> {

    String selectedValue = "";
    Map<int, String> brandData = {};

    DBHelper? dbHelper;
    late Future<List<FormatModel>> formatList;
    List<GetBrandData> _brandMasterList = [];

    void initState(){
      super.initState();
      dbHelper = DBHelper();
      loadData();
      getBrandData();
    }

    loadData () async{
      formatList = dbHelper!.getFormatList();
    }

    Future<void> getBrandData() async {
      _brandMasterList = await dbHelper!.getBrandListArray();
      for (int i = 0; i < _brandMasterList.length; i++) {
        brandData[_brandMasterList[i].brandId!] = _brandMasterList[i].brandName!;
      }
    }

    getBrandName(brandId){
      var brandName = "";
      if(brandId != ''){
        brandName = brandData[int.parse(brandId)].toString();
      }
      return brandName;
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: appbar(context, 'Formats', {'icons' : Icons.menu}),
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
                                      contentPadding: EdgeInsets.all(6),
                                      iconColor: constants.mainColor,
                                      titleTextStyle: TextStyle(color:constants.mainColor,fontSize: 16,fontWeight: FontWeight.bold),
                                      tileColor: Colors.white,
                                      title: Text(snapshot.data![index].formatName.toString()),
                                      subtitle: Text("Brand: "+getBrandName(snapshot.data![index].brandId)),
                                      trailing: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
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
              backgroundColor: constants.mainColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.0))
              ),
            ),
          )
      );
    }

  }