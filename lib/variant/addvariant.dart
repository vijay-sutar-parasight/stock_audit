import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/util/constants.dart' as constants;
import 'package:stock_audit/variant/variants.dart';

import '../../db_handler.dart';
import '../models/formatmodel.dart';
import '../models/variantmodel.dart';

class AddVariant extends StatefulWidget{
  @override
  State<AddVariant> createState() => _AddVariant();
}

class _AddVariant extends State<AddVariant>{
  var brandId = TextEditingController();
  var formatId = TextEditingController();
  var variantName = TextEditingController();

  DBHelper? dbHelper;

  void initState(){
    super.initState();
    dbHelper = DBHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Variant')
      ),
      body: Container(

          child: Column(
            children: [
              TextField(
                  controller: variantName,
                  decoration: InputDecoration(
                      hintText: 'Variant Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          )
                      ),
                      prefixIcon: Icon(Icons.list_alt, color: Colors.orange)

                  )
              ),
              Container(height: 11),
              TextField(
                controller: brandId,
                decoration: InputDecoration(
                    hintText: 'Select Brand',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(
                            color: Colors.deepOrange,
                            width: 2
                        )
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(
                            color: Colors.blueAccent,
                            width: 2
                        )
                    ),
                    prefixIcon: Icon(Icons.add_business, color: Colors.orange)
                ),
              ),
              Container(height: 20),
              TextField(
                controller: formatId,
                decoration: InputDecoration(
                    hintText: 'Select Format',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(
                            color: Colors.deepOrange,
                            width: 2
                        )
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(
                            color: Colors.blueAccent,
                            width: 2
                        )
                    ),
                    prefixIcon: Icon(Icons.add_business, color: Colors.orange)
                ),
              ),
              Container(height: 20),
              ElevatedButton(onPressed: (){
                String uBrandId = brandId.text.toString();
                String uFormatId = formatId.text.toString();
                String uVariantName = variantName.text;
                dbHelper!.insertVariant(
                    VariantModel(
                        brandId: uBrandId,
                        formatId: uFormatId,
                  variantName: uVariantName
                    )
                ).then((value) {
                  print('Data added Successfully');
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Variants()));
                }).onError((error, stackTrace) {
                  print(error.toString());
                });
              }, child: Text(
                  'Save'
              ))
            ],
          )),
    );
  }
}