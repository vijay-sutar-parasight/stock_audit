import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/brand/brands.dart';
import 'package:stock_audit/util/constants.dart' as constants;
import 'package:stock_audit/variant/variants.dart';

import '../appbar.dart';
import '../audit/audit.dart';
import '../db_handler.dart';
import '../models/auditmodel.dart';
import '../models/brandmodel.dart';
import '../models/companymodel.dart';
import '../models/formatmodel.dart';
import '../models/variantmodel.dart';
import 'company.dart';

class UpdateCompany extends StatefulWidget{
  @override
  State<UpdateCompany> createState() => _UpdateCompany();
}

class _UpdateCompany extends State<UpdateCompany>{
  var companyName = TextEditingController();
  var companyAddress = TextEditingController();
  var cmMobile = TextEditingController();
  var city = TextEditingController();
  var recordId;

  DBHelper? dbHelper;

  @override
  void initState(){
    super.initState();
    dbHelper = DBHelper();
  }

  @override
  Widget build(BuildContext context) {

    final updateCompany = ModalRoute.of(context)!.settings.arguments as CompanyModel;
    companyName.text = updateCompany.companyName!;
    companyAddress.text = updateCompany.companyAddress!;
    cmMobile.text = updateCompany.cmMobile!;
    city.text = updateCompany.city!;
    recordId = updateCompany.companyId!;
    return Scaffold(
      appBar: appbar(context, 'Update Company', {'icons' : Icons.menu}),
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
                      prefixIcon: Icon(Icons.add_business, color: Colors.orange)
                  ),
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
                Container(height: 11),

                TextField(
                    controller: cmMobile,
                    decoration: InputDecoration(
                        hintText: 'Mobile No',
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
                    controller: city,
                    decoration: InputDecoration(
                        hintText: 'City',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            )
                        ),
                        prefixIcon: Icon(Icons.list_alt, color: Colors.orange)

                    )
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
                    dbHelper!.updateCompany(
                        CompanyModel(
                          companyId: recordId,
                            companyName: uCompanyName,
                            companyAddress: uCompanyAddress,
                            cmMobile: uCmMobile,
                            city: uCity
                        )
                    ).then((value) {
                      constants.Notification("Company Updated Successfully");
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