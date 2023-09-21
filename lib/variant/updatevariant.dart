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

  String selectedBrand = "";
  String selectedFormat = "";
  Map<int, String> brandData = {};
  Map<int, String> formatData = {};

  DBHelper? dbHelper;

  @override
  void initState(){
    super.initState();
    dbHelper = DBHelper();
    getBrandData();
  }

  // Future<void> getBrandData() async {
  //   _brandMasterList = await dbHelper!.getBrandListArray();
  //   for (int i = 0; i < _brandMasterList.length; i++) {
  //     _brandList.add(_brandMasterList[i].brandName!);
  //     print(_brandMasterList[i].brandName!);
  //
  //   }
  // }

  Future<void> getFormatDataByBrand(selectedBrandId) async {
    _formatMasterList = await dbHelper!.getFormatListByBrand(selectedBrandId);
    print(_formatMasterList);
    for (int i = 0; i < _formatMasterList.length; i++) {
      // _formatList.add(_formatMasterList[i].formatName!);
      formatData[_formatMasterList[i].formatId!] = _formatMasterList[i].formatName!;
      print("selected brand id is $selectedBrandId");

    }
  }

  Future<void> getBrandData() async {
    _brandMasterList = await dbHelper!.getBrandListArray();
    for (int i = 0; i < _brandMasterList.length; i++) {
      brandData[_brandMasterList[i].brandId!] = _brandMasterList[i].brandName!;
    }
    setState(() {
    });
  }

  getBrandName(brandId){
    var brandName = "";
    if(brandId != ''){
      brandName = brandData[int.parse(brandId)].toString();
    }
    return brandName;
  }

  // Future<void> getFormatData() async {
  //   _formatMasterList = await dbHelper!.getFormatListArray();
  //   for (int i = 0; i < _formatMasterList.length; i++) {
  //     formatData[_formatMasterList[i].formatId!] = _formatMasterList[i].formatName!;
  //   }
  //   setState(() {
  //   });
  // }

  getFormatName(formatId){
    var formatName = "";
    if(formatId != ''){
      formatName = formatData[int.parse(formatId)].toString();
    }
    return formatName;
  }

  @override
  Widget build(BuildContext context) {

    final updateVariant = ModalRoute.of(context)!.settings.arguments as VariantModel;
    //brandId.text = updateVariant.brandId!;
    //formatId.text = updateVariant.formatId!;
    selectedBrand = getBrandName(updateVariant.brandId!);
    getFormatDataByBrand(updateVariant.brandId!).then((value) =>
        selectedFormat = getFormatName(updateVariant.formatId!)
        );
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
                items: brandData.values.toList(),
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Brand",
                    hintText: "Select Brand",
                  ),
                ),
                // onChanged: (val){
                //   setState(() {
                //     brandId.text = val!;
                //     _formatList.clear();
                //     getFormatDataByBrand(val);
                //   });
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
                selectedItem: selectedBrand,
              ),
              Container(height: 11),
              DropdownSearch<String>(
                popupProps: PopupProps.modalBottomSheet(
                  showSelectedItems: true,
                  //disabledItemFn: (String s) => s.startsWith('I'),
                ),
                items: formatData.values.toList(),
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Format",
                    hintText: "Select Format",
                  ),
                ),
                // onChanged: (val){
                //   formatId.text = val!;
                //   print(brandId.text.toString());
                // },
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