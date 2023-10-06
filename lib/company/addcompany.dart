import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stock_audit/util/constants.dart' as constants;
import 'package:stock_audit/variant/variants.dart';

import '../../db_handler.dart';
import '../appbar.dart';
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
      appBar: appbar(context, 'Add Company', {'icons' : Icons.menu}),
      body: Container(

          child: Padding(
            padding: const EdgeInsets.all(constants.bodyPadding),
            child: Column(
              children: [
                TextField(
                    controller: companyName,
                    decoration: InputDecoration(
                        hintText: 'Company Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide: BorderSide(
                              width: 1
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
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                              width: 1
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
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                              width: 1
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
                              width: 2
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                              width: 1
                          )
                      ),
                      prefixIcon: Icon(Icons.add_business, color: Colors.orange)
                  ),
                ),
                Container(height: 20),
                SizedBox(
                  width: constants.buttonWidth,
                  height: constants.buttonHeight,
                  child: ElevatedButton(onPressed: (){
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
                      constants.Notification("Company Added Successfully");
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => Company()));
                      Navigator.pop(context,value);
                    }).onError((error, stackTrace) {
                      print(error.toString());
                    });
                  }, child: Text(
                      'Save'
                      ,style: TextStyle(color: Colors.white,fontSize: 16)),
                      style: ElevatedButton.styleFrom(
                        primary: constants.mainColor, //background color of button
                        shape: RoundedRectangleBorder( //to set border radius to button
                            borderRadius: BorderRadius.circular(10)
                        ),
                      )
                  ),
                )
              ],
            ),
          )),
    );
  }
}