import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/brand/addbrand.dart';
import 'package:stock_audit/brand/updatebrand.dart';
import 'package:stock_audit/models/brandmodel.dart';
import 'package:stock_audit/util/constants.dart' as constants;
import 'package:http/http.dart' as http;

import '../appbar.dart';
import '../db_handler.dart';
import '../jsondata/GetCompanyData.dart';

class Brands extends StatefulWidget{
  @override
  State<Brands> createState() => BrandList();
}

class BrandList extends State<Brands>{

  DBHelper? dbHelper;
  late Future<List<BrandModel>> brandList;

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
    brandList = dbHelper!.getBrandList();
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
        appBar: appbar(context, 'Brands', {'icons' : Icons.menu}),
        body: Column(
          children: [
            // if (apiList != null)
            // getList(),
            Expanded(
              child: FutureBuilder(
                  future: brandList,
                  builder: (context, AsyncSnapshot<List<BrandModel>> snapshot){
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
                                    dbHelper!.deleteBrand(snapshot.data![index].brandId!);
                                    brandList = dbHelper!.getBrandList();
                                    snapshot.data!.remove(snapshot.data![index]);
                                  });
                                },
                                key: ValueKey<int>(snapshot.data![index]!.brandId!),
                                child: Card(
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(0),
                                    title: Text(snapshot.data![index].brandName.toString()),
                                    subtitle: Text(getCompanyName(snapshot.data![index].companyId)),
                                    trailing: Column(
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>  UpdateBrand(),
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddBrand()));
            },
            tooltip: 'Add Brand',
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