import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/brand/brands.dart';
import 'package:stock_audit/util/constants.dart' as constants;

import '../audit/audit.dart';
import '../db_handler.dart';
import '../jsondata/GetBrandData.dart';
import '../models/auditmodel.dart';
import '../models/brandmodel.dart';
import '../models/formatmodel.dart';
import 'formats.dart';

class UpdateFormat extends StatefulWidget{
  @override
  State<UpdateFormat> createState() => _UpdateFormat();
}

class _UpdateFormat extends State<UpdateFormat>{
  var brandId = TextEditingController();
  var formatName = TextEditingController();
  var recordId;

  List<String> _brandList = [];
  List<GetBrandData> _brandMasterList = [];

  DBHelper? dbHelper;

  @override
  void initState(){
    super.initState();
    dbHelper = DBHelper();
    getBrandData();
  }

  Future<void> getBrandData() async {
    _brandMasterList = await dbHelper!.getBrandListArray();
    for (int i = 0; i < _brandMasterList.length; i++) {

      _brandList.add(_brandMasterList[i].brandName!);
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final updateFormat = ModalRoute.of(context)!.settings.arguments as FormatModel;
    brandId.text = updateFormat.brandId!;
    formatName.text = updateFormat.formatName!;
    recordId = updateFormat.formatId!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Format')
      ),
      body: Container(
          child: Column(
            children: [
              TextField(
                  controller: formatName,
                  decoration: InputDecoration(
                      hintText: 'Format Name',
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

              DropdownSearch<String>(
                popupProps: PopupProps.modalBottomSheet(
                  showSelectedItems: true,
                  disabledItemFn: (String s) => s.startsWith('I'),
                ),
                items: _brandList,
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Brand",
                    hintText: "Select Brand",
                  ),
                ),
                onChanged: (val){

                  brandId.text = val!;
                },
                selectedItem: brandId.text,
              ),
              Container(height: 20),


              ElevatedButton(onPressed: (){
                String uBrandId = brandId.text.toString();
                String uFormatName = formatName.text;

                if(uBrandId == ''){
                  uBrandId = updateFormat.brandId.toString();
                }

                dbHelper!.updateFormat(
                    FormatModel(
                      formatId: recordId,
                  brandId: uBrandId,
                      formatName: uFormatName,
                    )
                ).then((value) {
                  constants.Notification("Format Updated Successfully");
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => Formats()));
                  Navigator.pop(context,value);
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