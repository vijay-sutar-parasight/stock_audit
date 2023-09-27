import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/util/constants.dart' as constants;
import 'package:http/http.dart' as http;
import 'package:stock_audit/warehouse/updatewarehouse.dart';

import '../appbar.dart';
import '../db_handler.dart';
import '../jsondata/GetCompanyData.dart';
import '../models/warehousemodel.dart';
import 'addwarehouse.dart';

class Warehouse extends StatefulWidget {
  @override
  State<Warehouse> createState() => WarehouseList();
}
  class WarehouseList extends State<Warehouse> {

    DBHelper? dbHelper;
    late Future<List<WarehouseModel>> warehouseList;

    List<GetCompanyData> _companyMasterList = [];

    String selectedValue = "";
    Map<int, String> companyData = {};

    @override
  void initState(){
      super.initState();
      dbHelper = DBHelper();
      loadData();
      getCompanyData();
    }

    loadData () async{
      warehouseList = dbHelper!.getWarehouseList();
    }

    Future<void> getCompanyData() async {
      _companyMasterList = await dbHelper!.getCompanyListArray();
      for (int i = 0; i < _companyMasterList.length; i++) {
        companyData[_companyMasterList[i].companyId!] = _companyMasterList[i].companyName!;
      }
    }

    getCompanyName(companyId){
      var companyName = "";
      if(companyId != ''){
        companyName = companyData[int.parse(companyId)].toString();
      }
      return companyName;
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
                                      contentPadding: EdgeInsets.all(6),
                                      iconColor: constants.mainColor,
                                      titleTextStyle: TextStyle(color:constants.mainColor,fontSize: 16,fontWeight: FontWeight.bold),
                                      tileColor: Colors.white,
                                      title: Text(snapshot.data![index].warehouseName.toString()),
                                      subtitle: Text(getCompanyName(snapshot.data![index].companyId)),
                                      trailing: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
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
              backgroundColor: constants.mainColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.0))
              ),
            ),
          )
      );
    }

  }