import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/brand/brands.dart';
import 'package:stock_audit/util/constants.dart' as constants;
import 'package:stock_audit/variant/variants.dart';

import '../appbar.dart';
import '../audit/audit.dart';
import '../db_handler.dart';
import '../jsondata/GetBrandData.dart';
import '../jsondata/GetFormatData.dart';
import '../models/auditmodel.dart';
import '../models/brandmodel.dart';
import '../models/formatmodel.dart';
import '../models/variantmodel.dart';

class UpdateVariant extends StatefulWidget{
  @override
  State<UpdateVariant> createState() => _UpdateVariant();
}

class _UpdateVariant extends State<UpdateVariant>{
  var brandId = TextEditingController();
  var formatId = TextEditingController();
  var variantName = TextEditingController();
  var recordId;

  List<String> _brandList = [];
  List<GetBrandData> _brandMasterList = [];
  List<String> _formatList = [];
  List<GetFormatData> _formatMasterList = [];

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
      print(_brandMasterList[i].brandName!);

    }
  }

  Future<void> getFormatDataByBrand(selectedBrandId) async {
    _formatMasterList = await dbHelper!.getFormatListByBrand(selectedBrandId);
    print(_formatMasterList);
    for (int i = 0; i < _formatMasterList.length; i++) {
      _formatList.add(_formatMasterList[i].formatName!);
      print("selected brand id is $selectedBrandId");

    }
  }

  @override
  Widget build(BuildContext context) {

    final updateVariant = ModalRoute.of(context)!.settings.arguments as VariantModel;
    //brandId.text = updateVariant.brandId!;
    //formatId.text = updateVariant.formatId!;
    variantName.text = updateVariant.variantName!;
    recordId = updateVariant.variantId!;

    // getFormatDataByBrand(updateVariant.brandId);


    return Scaffold(
      appBar: appbar(context, 'Update Variant', {'icons' : Icons.menu}),
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
                  showSearchBox: true,
                  // disabledItemFn: (String s) => s.startsWith('I'),
                ),
                items: _brandList,
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Brand",
                    hintText: "Select Brand",
                  ),
                ),
                onChanged: (val){
                  setState(() {
                    brandId.text = val!;
                    _formatList.clear();
                    getFormatDataByBrand(val);
                  });
                },
                selectedItem: updateVariant.brandId,
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
                  print(brandId.text.toString());
                },
                selectedItem: updateVariant.formatId,
              ),
              Container(height: 20),

              ElevatedButton(onPressed: (){
                String uBrandId = brandId.text.toString();
                String uFormatId = formatId.text.toString();
                String uVariantName = variantName.text;

                if(uBrandId == ''){
                  uBrandId = updateVariant.brandId.toString();
                }
                if(uFormatId == ''){
                  uFormatId = updateVariant.formatId.toString();
                }

                dbHelper!.updateVariant(
                    VariantModel(
                      variantId: recordId,
                  formatId: uFormatId,
                  brandId: uBrandId,
                      variantName: uVariantName,
                    )
                ).then((value) {
                  constants.Notification("Variant Updated Successfully");
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