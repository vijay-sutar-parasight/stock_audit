import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/util/constants.dart' as constants;
import 'package:stock_audit/variant/variants.dart';

import '../../db_handler.dart';
import '../appbar.dart';
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

  String selectedBrand = "";
  String selectedFormat = "";
  Map<int, String> brandData = {};
  Map<int, String> formatData = {};

  DBHelper? dbHelper;

  void initState(){
    super.initState();
    dbHelper = DBHelper();
    getBrandData();
  }

  Future<void> getBrandData() async {
    _brandMasterList = await dbHelper!.getBrandListArray();
    for (int i = 0; i < _brandMasterList.length; i++) {
      brandData[_brandMasterList[i].brandId!] = _brandMasterList[i].brandName!;
    }
    setState(() {
    });
  }

  Future<void> getFormatDataByBrand(selectedBrandId) async {
    _formatMasterList = await dbHelper!.getFormatListByBrand(selectedBrandId);
    print(_formatMasterList);
    for (int i = 0; i < _formatMasterList.length; i++) {
      // _formatList.add(_formatMasterList[i].formatName!);
      formatData[_formatMasterList[i].formatId!] = _formatMasterList[i].formatName!;
      print("selected brand id is $selectedBrandId");

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context, 'Add Variant', {'icons' : Icons.menu}),
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
                  //disabledItemFn: (String s) => s.startsWith('I'),
                ),
                items: brandData.values.toList(),
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Brand",
                    hintText: "Select Brand",
                  ),
                ),
                // onChanged: (val){
                //   brandId.text = val!;
                //   _formatList.clear();
                //   getFormatDataByBrand(val);
                // },
                onChanged: (val){
                  var key = brandData.keys.firstWhere((k)
                  => brandData[k] == val!, orElse: () => 0);

                  setState(() {
                    selectedBrand = val!;
                    brandId.text = key!.toString();
                    formatData.clear();
                    getFormatDataByBrand(brandId.text);
                    selectedFormat= "";
                  });
                  print(brandId.text);
                },
                selectedItem: "",
              ),
              Container(height: 11),
              DropdownSearch<String>(
                popupProps: PopupProps.modalBottomSheet(
                  showSelectedItems: true,
                  disabledItemFn: (String s) => s.startsWith('I'),
                ),
                items: formatData.values.toList(),
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Format",
                    hintText: "Select Format",
                  ),
                ),
                onChanged: (val){
                  var key = formatData.keys.firstWhere((k)
                  => formatData[k] == val!, orElse: () => 0);

                  setState(() {
                    selectedFormat = val!;
                    formatId.text = key!.toString();
                  });
                  print(formatId.text);
                },
                selectedItem: selectedFormat,
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