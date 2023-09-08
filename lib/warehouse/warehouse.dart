import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/util/constants.dart' as constants;
import 'package:http/http.dart' as http;
import 'package:stock_audit/warehouse/updatewarehouse.dart';

import '../appbar.dart';
import '../db_handler.dart';
import '../models/warehousemodel.dart';
import 'addwarehouse.dart';

class Warehouse extends StatefulWidget {
  @override
  State<Warehouse> createState() => WarehouseList();
}
  class WarehouseList extends State<Warehouse> {

    DBHelper? dbHelper;
    late Future<List<WarehouseModel>> warehouseList;

    @override
  void initState(){
      super.initState();
      dbHelper = DBHelper();
      loadData();
    }

    loadData () async{
      warehouseList = dbHelper!.getWarehouseList();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: appbar(context, 'Warehouse', {'icons' : Icons.menu}),
          body: Column(
            children: [
              // if (apiList != null)
              // getList(),
              Expanded(
                child: FutureBuilder(
                    future: warehouseList,
                    builder: (context, AsyncSnapshot<List<WarehouseModel>> snapshot){
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
                                      dbHelper!.deleteBrand(snapshot.data![index].warehouseId!);
                                      warehouseList = dbHelper!.getWarehouseList();
                                      snapshot.data!.remove(snapshot.data![index]);
                                    });
                                  },
                                  key: ValueKey<int>(snapshot.data![index]!.warehouseId!),
                                  child: Card(
                                    child: ListTile(
                                      contentPadding: EdgeInsets.all(0),
                                      title: Text(snapshot.data![index].warehouseName.toString()),
                                      subtitle: Text(snapshot.data![index].companyId.toString()),
                                      trailing: Column(
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>  UpdateWarehouse(),
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddWarehouse()));
              },
              tooltip: 'Add Warehouse',
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