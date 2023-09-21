import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/description/updatedescription.dart';
import 'package:stock_audit/util/constants.dart' as constants;
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../appbar.dart';
import '../db_handler.dart';
import '../models/productmodel.dart';
import 'adddescription.dart';

class Descriptions extends StatefulWidget{
  @override
  State<Descriptions> createState() => DescriptionList();
}

class DescriptionList extends State<Descriptions> {
  DBHelper? dbHelper;
  late Future<List<ProductModel>> productList;

  void initState(){
    super.initState();
    dbHelper = DBHelper();
    loadData();
  }

  loadData () async{
    productList = dbHelper!.getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar(context, 'Description', {'icons' : Icons.menu}),
        body: Column(
          children: [
            // if (apiList != null)
            // getList(),
            Expanded(
              child: FutureBuilder(
                  future: productList,
                  builder: (context, AsyncSnapshot<List<ProductModel>> snapshot){
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
                                    dbHelper!.deleteProduct(snapshot.data![index].productId!);
                                    productList = dbHelper!.getProductList();
                                    snapshot.data!.remove(snapshot.data![index]);
                                  });
                                },
                                key: ValueKey<int>(snapshot.data![index]!.productId!),
                                child: Card(
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(0),
                                    title: Text(snapshot.data![index].productName.toString()),
                                    subtitle: Text("Item No: "+snapshot.data![index].itemNumber.toString()),
                                    trailing: Column(
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => UpdateDescription(),
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddDescription()));
            },
            tooltip: 'Add Description',
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