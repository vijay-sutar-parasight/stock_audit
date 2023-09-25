import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/description/descriptions.dart';
import 'package:stock_audit/util/constants.dart' as constants;
import 'package:stock_audit/variant/variants.dart';
import 'package:stock_audit/warehouse/warehouse.dart';

import '../../db_handler.dart';
import '../appbar.dart';
import '../jsondata/GetBrandData.dart';
import '../jsondata/GetCompanyData.dart';
import '../jsondata/GetFormatData.dart';
import '../jsondata/GetVariantData.dart';
import '../jsondata/GetWarehouseData.dart';
import '../models/formatmodel.dart';
import '../models/productmodel.dart';
import '../models/variantmodel.dart';
import '../models/warehousemodel.dart';

class AddDescription extends StatefulWidget{
  @override
  State<AddDescription> createState() => _AddDescription();
}

class _AddDescription extends State<AddDescription>{
  var productId = TextEditingController();
  var productName = TextEditingController();
  var itemNumber = TextEditingController();
  var companyId = TextEditingController();
  var formatId = TextEditingController();
  var brandId = TextEditingController();
  var variantId = TextEditingController();
  var warehouseId = TextEditingController();
  var systemUnit = TextEditingController();
  var valuationPerUnit = TextEditingController();
  var weight = TextEditingController();
  var mrp = TextEditingController();
  var combiType = TextEditingController();
  var pcsCases = TextEditingController();
  var totalStockValue = TextEditingController();
  var mfgDate = TextEditingController();
  var mfgMonth = TextEditingController();
  var mfgYear = TextEditingController();
  var expDate = TextEditingController();
  var expMonth = TextEditingController();
  var expYear = TextEditingController();

  List<String> _CompanyList = [];
  List<GetCompanyData> _companyMasterList = [];
  List<String> _brandList = [];
  List<GetBrandData> _brandMasterList = [];
  List<String> _formatList = [];
  List<GetFormatData> _formatMasterList = [];
  List<String> _variantList = [];
  List<GetVariantData> _variantMasterList = [];
  List<String> _warehouseList = [];
  List<GetWarehouseData> _warehouseMasterList = [];

  List<String> _months = ['January','February','March','April','May','June','July','August','September','October','November','December'];
  List<String> _years = [];
  int fromYear = 2000;
  int toYear = 2050;

  DBHelper? dbHelper;

  String selectedCompany = "";
  Map<String, String> companyData = {};
  String selectedBrand = "";
  Map<String, String> brandData = {};
  String selectedFormat = "";
  Map<String, String> formatData = {};
  String selectedVariant = "";
  Map<String, String> variantData = {};
  String selectedWarehouse = "";
  Map<String, String> warehouseData = {};

  void initState(){
    super.initState();
    dbHelper = DBHelper();
    getCompanyData();
    getYears();
  }

  Future<void> getYears() async {
    for (int i = fromYear; i < toYear; i++) {
      _years.add(i.toString());
    }
  }

  Future<void> getCompanyData() async {
    _companyMasterList = await dbHelper!.getCompanyListArray();
    for (int i = 0; i < _companyMasterList.length; i++) {
      // _CompanyList.add(_companyMasterList[i].companyName!);
      companyData[_companyMasterList[i].companyId!.toString()] = _companyMasterList[i].companyName!;
    }
    setState(() {

    });
  }

  getCompanyName(companyId){
    var companyName = "";
    if(companyId != ''){
      companyName = companyData[companyId].toString();
    }
    return companyName;
  }

  Future<void> getBrandData(selectedCompanyId) async {
    _brandMasterList = await dbHelper!.getBrandListByCompany(selectedCompanyId);
    for (int i = 0; i < _brandMasterList.length; i++) {
      //_brandList.add(_brandMasterList[i].brandName!);
      brandData[_brandMasterList[i].brandId!.toString()] = _brandMasterList[i].brandName!;
      setState(() {

      });
    }
  }

  getBrandName(brandId){
    var brandName = "";
    if(brandId != ''){
      brandName = brandData[brandId].toString();
    }
    return brandName;
  }

  Future<void> getFormatDataByBrand(brandId) async {
    _formatMasterList = await dbHelper!.getFormatListByBrand(brandId);
    // print(_formatMasterList);
    for (int i = 0; i < _formatMasterList.length; i++) {
      //_formatList.add(_formatMasterList[i].formatName!);
      formatData[_formatMasterList[i].formatId!.toString()] = _formatMasterList[i].formatName!;
      setState(() {
      });
    }
  }

  getFormatName(formatId){
    var formatName = "";
    if(formatId != ''){
      formatName = formatData[formatId].toString();
    }
    return formatName;
  }


  Future<void> getVariantDataByBrandAndFormat(brandId,formatId) async {
    _variantMasterList = await dbHelper!.getVariantListByBrandAndFormat(brandId,formatId);
    // print(companyId.text+" "+formatId);
    for (int i = 0; i < _variantMasterList.length; i++) {
      // _variantList.add(_variantMasterList[i].variantName!);
      variantData[_variantMasterList[i].variantId!.toString()] = _variantMasterList[i].variantName!;
      setState(() {
      });
    }
  }

  getVariantName(variantId){
    var variantName = "";
    if(variantId != ''){
      variantName = variantData[variantId].toString();
    }
    return variantName;
  }

  Future<void> getWarehouseData(selectedCompanyId) async {
    _warehouseMasterList = await dbHelper!.getWarehouseDataByCompany(selectedCompanyId);
    for (int i = 0; i < _warehouseMasterList.length; i++) {
      warehouseData[_warehouseMasterList[i].warehouseId!.toString()] = _warehouseMasterList[i].warehouseName!;
      setState(() {

      });
    }
  }

  getWarehouseName(warehouseId){
    var warehouseName = "";
    if(warehouseId != ''){
      warehouseName = warehouseData[warehouseId].toString();
    }
    return warehouseName;
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context, 'Add Description', {'icons' : Icons.menu}),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: TextField(
                        controller: itemNumber,
                        decoration: InputDecoration(
                          hintText: 'Item Number',
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
                          prefixIcon: Icon(Icons.add_business, color: Colors.orange),
                          contentPadding: EdgeInsets.symmetric(vertical: 15),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),

                    Flexible(
                      child: TextField(
                          controller: productName,
                          decoration: InputDecoration(
                            hintText: 'Description Name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                )
                            ),
                            prefixIcon: Icon(Icons.list_alt, color: Colors.orange),
                            contentPadding: EdgeInsets.symmetric(vertical: 15),

                          )
                      ),
                    ),
                  ],
                ),

                Container(height: 11),
                Row(
                  children: [
                    Flexible(
                      child: DropdownSearch<String>(
                        popupProps: PopupProps.modalBottomSheet(
                          showSelectedItems: true,
                          //disabledItemFn: (String s) => s.startsWith('I'),
                        ),
                        items: companyData.values.toList(),
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            labelText: "Company",
                            hintText: "Select Company",
                          ),
                        ),
                        onChanged: (val){
                          var key = companyData.keys.firstWhere((k)
                          => companyData[k] == val!, orElse: () => "");
                          companyId.text = key!;
                          brandData.clear();
                          formatData.clear();
                          variantData.clear();
                          warehouseData.clear();
                          getBrandData(companyId.text);
                          getWarehouseData(companyId.text);
                          selectedCompany = val!;
                          selectedBrand="";
                        },
                        selectedItem: selectedCompany,
                      ),
                    ),
                    SizedBox(width: 10),

                    Flexible(
                      child: DropdownSearch<String>(
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
                        onChanged: (val){
                          var key = brandData.keys.firstWhere((k)
                          => brandData[k] == val!, orElse: () => "");
                          brandId.text = key!;
                          brandData.clear();
                          getFormatDataByBrand(brandId.text);
                        },
                        selectedItem: selectedBrand,
                      ),
                    ),
                  ],
                ),
                Container(height: 11),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: DropdownSearch<String>(
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
                        onChanged: (val){
                          var key = formatData.keys.firstWhere((k)
                          => formatData[k] == val!, orElse: () => "");
                          formatId.text = key!;
                          variantData.clear();
                          selectedVariant = "";
                          getVariantDataByBrandAndFormat(brandId.text, formatId.text);
                        },
                        selectedItem: selectedFormat,
                      ),
                    ),
                    SizedBox(width: 10),

                    Flexible(
                      child: DropdownSearch<String>(
                        popupProps: PopupProps.modalBottomSheet(
                          showSelectedItems: true,
                          //disabledItemFn: (String s) => s.startsWith('I'),
                        ),
                        items: variantData.values.toList(),
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            labelText: "Variant",
                            hintText: "Select Variant",
                          ),
                        ),
                        onChanged: (val){
                          var key = variantData.keys.firstWhere((k)
                          => variantData[k] == val!, orElse: () => "");
                          variantId.text = key!;
                        },
                        selectedItem: selectedVariant,
                      ),
                    ),

                  ],
                ),


                Container(height: 11),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: DropdownSearch<String>(
                        popupProps: PopupProps.modalBottomSheet(
                          showSelectedItems: true,
                          //disabledItemFn: (String s) => s.startsWith('I'),
                        ),
                        items: warehouseData.values.toList(),
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            labelText: "Warehouse",
                            hintText: "Select Warehouse",
                          ),
                        ),
                        onChanged: (val){
                          var key = warehouseData.keys.firstWhere((k)
                          => warehouseData[k] == val!, orElse: () => "");
                          warehouseId.text = key!;
                        },
                        selectedItem: "",
                      ),
                    ),
                    SizedBox(width: 10),

                    Flexible(
                      child: DropdownSearch<String>(
                        popupProps: PopupProps.modalBottomSheet(
                          showSelectedItems: true,
                          //disabledItemFn: (String s) => s.startsWith('I'),
                        ),
                        items: _months,
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            labelText: "MFG Month",
                            hintText: "Select MFG Month",
                          ),
                        ),
                        onChanged: (val){
                          mfgMonth.text = val!;
                        },
                        selectedItem: "",
                      ),
                    ),
                  ],
                ),
                Container(height: 11),
                Row(
                  children: [
                    Flexible(
                      child: DropdownSearch<String>(
                        popupProps: PopupProps.modalBottomSheet(
                          showSelectedItems: true,
                          disabledItemFn: (String s) => s.startsWith('I'),
                        ),
                        items: _years,
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            labelText: "MFG Year",
                            hintText: "Select MFG Year",
                          ),
                        ),
                        onChanged: (val){
                          mfgYear.text = val!;
                        },
                        selectedItem: "",
                      ),
                    ),
                    SizedBox(width: 10),

                    Flexible(
                      child: DropdownSearch<String>(
                        popupProps: PopupProps.modalBottomSheet(
                          showSelectedItems: true,
                          disabledItemFn: (String s) => s.startsWith('I'),
                        ),
                        items: _months,
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            labelText: "EXP Month",
                            hintText: "Select EXP Month",
                          ),
                        ),
                        onChanged: (val){
                          expMonth.text = val!;
                        },
                        selectedItem: "",
                      ),
                    ),
                  ],
                ),

                Container(height: 11),
                Row(
                  children: [
                    Flexible(
                      child: DropdownSearch<String>(
                        popupProps: PopupProps.modalBottomSheet(
                          showSelectedItems: true,
                          disabledItemFn: (String s) => s.startsWith('I'),
                        ),
                        items: _years,
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            labelText: "EXP Month",
                            hintText: "Select EXP Month",
                          ),
                        ),
                        onChanged: (val){
                          mfgMonth.text = val!;
                        },
                        selectedItem: "",
                      ),
                    ),
                    SizedBox(width: 10),

                    Flexible(
                      child: TextField(
                          controller: weight,
                          decoration: InputDecoration(
                            hintText: 'Weight',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                )
                            ),
                            prefixIcon: Icon(Icons.list_alt, color: Colors.orange),
                            contentPadding: EdgeInsets.symmetric(vertical: 15),

                          )
                      ),
                    ),
                  ],
                ),

                Container(height: 11),
                TextField(
                    controller: mrp,
                    decoration: InputDecoration(
                      hintText: 'MRP',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          )
                      ),
                      prefixIcon: Icon(Icons.list_alt, color: Colors.orange),
                      contentPadding: EdgeInsets.symmetric(vertical: 15),

                    )
                ),
                Container(height: 11),
                TextField(
                    controller: systemUnit,
                    decoration: InputDecoration(
                      hintText: 'System Unit',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          )
                      ),
                      prefixIcon: Icon(Icons.list_alt, color: Colors.orange),
                      contentPadding: EdgeInsets.symmetric(vertical: 15),

                    )
                ),
                Container(height: 11),
                Row(
                  children: [
                    Flexible(
                      child: TextField(
                          controller: valuationPerUnit,
                          decoration: InputDecoration(
                            hintText: 'Valuation Per Unit',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                )
                            ),
                            prefixIcon: Icon(Icons.list_alt, color: Colors.orange),
                            contentPadding: EdgeInsets.symmetric(vertical: 15),

                          )
                      ),
                    ),
                    SizedBox(width: 10),

                    Flexible(
                      child: TextField(
                          controller: combiType,
                          decoration: InputDecoration(
                            hintText: 'Combi Type',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                )
                            ),
                            prefixIcon: Icon(Icons.list_alt, color: Colors.orange),
                            contentPadding: EdgeInsets.symmetric(vertical: 15),

                          )
                      ),
                    ),
                  ],
                ),

                Container(height: 11),
                Row(
                  children: [
                    Flexible(
                      child: TextField(
                          controller: pcsCases,
                          decoration: InputDecoration(
                            hintText: 'PCS/Cases',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                )
                            ),
                            prefixIcon: Icon(Icons.list_alt, color: Colors.orange),
                            contentPadding: EdgeInsets.symmetric(vertical: 15),

                          )
                      ),
                    ),
                    SizedBox(width: 10),

                    Flexible(
                      child: TextField(
                          controller: totalStockValue,
                          decoration: InputDecoration(
                            hintText: 'Total Stock Value',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                )
                            ),
                            prefixIcon: Icon(Icons.list_alt, color: Colors.orange),
                            contentPadding: EdgeInsets.symmetric(vertical: 15),

                          )
                      ),
                    ),
                  ],
                ),

                // Container(height: 20),
                // DropdownButton(
                //     value: selectedItem, items: statusDropdown.map((e) {
                //   return DropdownmodalBottomSheetItem(value: e,child: Text(e));
                // }).toList(), onChanged: (val){
                //   setState(() {
                //     selectedItem = val as String;
                //   });
                // }),
                Container(height: 20),
                ElevatedButton(onPressed: (){
                  String uItemNumber = itemNumber.text.toString();
                  String uDescriptionName = productName.text.toString();
                  String uCompanyId = companyId.text.toString();
                  String uBrandId = brandId.text.toString();
                  String uFormatId = formatId.text.toString();
                  String uVariantId = variantId.text.toString();
                  String uWarehouseId = warehouseId.text.toString();
                  String uMfgMonth = mfgMonth.text.toString();
                  String uMfgYear = mfgYear.text.toString();
                  String uExpMonth = expMonth.text.toString();
                  String uExpYear = expYear.text.toString();
                  String uWeight = weight.text.toString();
                  String uMrp = mrp.text.toString();
                  String uSystemUnit = systemUnit.text.toString();
                  String uValuationPerUnit = valuationPerUnit.text.toString();
                  String uCombiType = combiType.text.toString();
                  String uPcsCases = pcsCases.text.toString();
                  String uTotalStockValue = totalStockValue.text.toString();
                  dbHelper!.insertProduct(
                      ProductModel(
                          itemNumber: uItemNumber,
                          productName: uDescriptionName,
                          companyId: uCompanyId,
                          brandId: uBrandId,
                          formatId: uFormatId,
                          variantId: uVariantId,
                          warehouseId: uWarehouseId,
                          mfgMonth: uMfgMonth,
                          mfgYear: uMfgYear,
                          expMonth: uExpMonth,
                          expYear: uExpYear,
                          weight: uWeight,
                          mrp: uMrp,
                          valuationPerUnit: uValuationPerUnit,
                          systemUnit: uSystemUnit,
                          combiType: uCombiType,
                          pcsCases: uPcsCases,
                          totalStockValue: uTotalStockValue
                      )
                  ).then((value) {
                    constants.Notification("Description Added Successfully");
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => Descriptions()));
                    Navigator.pop(context,value);
                  }).onError((error, stackTrace) {
                    print(error.toString());
                  });
                }, child: Text(
                    'Save'
                ))
              ],
            )
        ),
      ),
    );
  }

}