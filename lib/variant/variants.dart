import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/util/constants.dart' as constants;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stock_audit/variant/updatevariant.dart';

import '../db_handler.dart';
import '../models/variantmodel.dart';
import 'addvariant.dart';

class Variants extends StatefulWidget{
  @override
  State<Variants> createState() => VariantList();
}

class VariantList extends State<Variants> {
  DBHelper? dbHelper;
  late Future<List<VariantModel>> variantList;

  @override
  void initState(){
    super.initState();
    dbHelper = DBHelper();
    loadData();
  }

  loadData () async{
    variantList = dbHelper!.getVariantList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Variants')
        ),
        body: Column(
          children: [
            // if (apiList != null)
            // getList(),
            Expanded(
              child: FutureBuilder(
                  future: variantList,
                  builder: (context, AsyncSnapshot<List<VariantModel>> snapshot){
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
                                    dbHelper!.deleteVariant(snapshot.data![index].variantId!);
                                    variantList = dbHelper!.getVariantList();
                                    snapshot.data!.remove(snapshot.data![index]);
                                  });
                                },
                                key: ValueKey<int>(snapshot.data![index]!.variantId!),
                                child: Card(
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(0),
                                    title: Text(snapshot.data![index].variantName.toString()),
                                    subtitle: Text(snapshot.data![index].brandId.toString()),
                                    trailing: Column(
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>  UpdateVariant(),
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddVariant()));
            },
            tooltip: 'Add Variant',
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