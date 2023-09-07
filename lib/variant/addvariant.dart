import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/util/constants.dart' as constants;
import 'package:stock_audit/variant/variants.dart';

import '../../db_handler.dart';
import '../jsondata/GetBrandData.dart';
import '../jsondata/GetFormatData.dart';
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

  List<String> _brandList = [];
  List<GetBrandData> _brandMasterList = [];
  List<String> _formatList = [];
  List<GetFormatData> _formatMasterList = [];

  DBHelper? dbHelper;

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

  Future<void> getFormatDataByBrand(brandId) async {
    _formatMasterList = await dbHelper!.getFormatListByBrand(brandId);
    print(_formatMasterList);
    for (int i = 0; i < _formatMasterList.length; i++) {
      _formatList.add(_formatMasterList[i].formatName!);
      setState(() {
      });
    }
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
                  _formatList.clear();
                  getFormatDataByBrand(val);
                },
                selectedItem: "",
              ),
              Container(height: 11),
              DropdownSearch<String>(
                popupProps: PopupProps.modalBottomSheet(
                  showSelectedItems: true,
                  disabledItemFn: (String s) => s.startsWith('I'),
                ),
                items: _formatList,
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Format",
                    hintText: "Select Format",
                  ),
                ),
                onChanged: (val){
                  formatId.text = val!;
                },
                selectedItem: "",
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
                  constants.Notification("Variant Added Successfully");
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => Variants()));
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