import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/util/constants.dart' as constants;
import 'package:stock_audit/variant/variants.dart';

import '../../db_handler.dart';
import '../models/companymodel.dart';
import '../models/formatmodel.dart';
import '../models/variantmodel.dart';
import 'company.dart';

class AddCompany extends StatefulWidget{
  @override
  State<AddCompany> createState() => _AddCompany();
}

class _AddCompany extends State<AddCompany>{
  var companyName = TextEditingController();
  var companyAddress = TextEditingController();
  var cmMobile = TextEditingController();
  var city = TextEditingController();

  DBHelper? dbHelper;

  void initState(){
    super.initState();
    dbHelper = DBHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Company')
      ),
      body: Container(

          child: Column(
            children: [
              TextField(
                  controller: companyName,
                  decoration: InputDecoration(
                      hintText: 'Company Name',
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
                controller: companyAddress,
                decoration: InputDecoration(
                    hintText: 'Company Address',
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
                controller: cmMobile,
                decoration: InputDecoration(
                    hintText: 'Mobile No',
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
              Container(height: 11),

              TextField(
                controller: city,
                decoration: InputDecoration(
                    hintText: 'City',
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
                String uCompanyName = companyName.text.toString();
                String uCompanyAddress = companyAddress.text.toString();
                String uCmMobile = cmMobile.text;
                String uCity = city.text;
                dbHelper!.insertCompany(
                    CompanyModel(
                        companyName: uCompanyName,
                        companyAddress: uCompanyAddress,
                        cmMobile: uCmMobile,
                  city: uCity
                    )
                ).then((value) {
                  print('Data added Successfully');
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Company()));
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