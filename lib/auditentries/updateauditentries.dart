import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:stock_audit/util/constants.dart' as constants;

import '../../models/auditentriesmodel.dart';
import '../appbar.dart';
import '../db_handler.dart';
import '../jsondata/GetBrandData.dart';
import '../jsondata/GetCompanyData.dart';
import '../jsondata/GetDescriptionData.dart';
import '../jsondata/GetFormatData.dart';
import '../jsondata/GetVariantData.dart';
import '../jsondata/GetWarehouseData.dart';
import 'auditentries.dart';
import 'auditentries_handler.dart';

class UpdateAuditEntries extends StatefulWidget{
  String selectedCompanyId;
  String selectedAuditId;
  UpdateAuditEntries({required this.selectedCompanyId, required this.selectedAuditId});
  @override
  State<UpdateAuditEntries> createState() => _UpdateAuditEntries(selectedCompanyId, selectedAuditId);
}

class _UpdateAuditEntries extends State<UpdateAuditEntries>{

  String selectedCompanyId;
  String selectedAuditId;
  String? selectedMfgMonth;
  String? selectedMfgYear;
  String? selectedExpMonth;
  String? selectedExpYear;
  double existingActualUnits = 0;
  _UpdateAuditEntries(this.selectedCompanyId, this.selectedAuditId);
  TextEditingController companyId = TextEditingController();
  var brandId = TextEditingController();
  var formatId = TextEditingController();
  var variantId = TextEditingController();
  var descriptionId = TextEditingController();
  var mfgMonth = TextEditingController();
  var mfgYear = TextEditingController();
  var expMonth = TextEditingController();
  var expYear = TextEditingController();
  var warehouseId = TextEditingController();
  var weight = TextEditingController();
  var mrp = TextEditingController();
  var valuationPerUnit = TextEditingController();
  var systemUnit = TextEditingController();
  var calculation = TextEditingController();
  var actualUnits = TextEditingController();
  var totalValuation = TextEditingController();

  var recordId;

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
  List<String> _descriptionList = [];
  List<GetDescriptionData> _descriptionMasterList = [];
  List<String> _calculationArr = [];
  List<String> _months = ['January','February','March','April','May','June','July','August','September','October','November','December'];
  List<String> _years = [];
  int fromYear = 2000;
  int toYear = 2050;

  AuditentriesDBHelper? dbHelper;
  DBHelper? db;

  String selectedBrand = "";
  Map<String, String> brandData = {};
  String selectedFormat = "";
  Map<String, String> formatData = {};
  String selectedVariant = "";
  Map<String, String> variantData = {};
  String selectedWarehouse = "";
  Map<String, String> warehouseData = {};
  String selectedDescription = "";
  Map<String, String> descriptionData = {};

  void initState(){
    super.initState();
    dbHelper = AuditentriesDBHelper();
    db = DBHelper();
    getBrandData(selectedCompanyId);
    getWarehouseData(selectedCompanyId);
    getYears();
  }

  Future<void> getYears() async {
    for (int i = fromYear; i < toYear; i++) {
      _years.add(i.toString());
    }
  }

  Future<void> getBrandData(selectedCompanyId) async {
    _brandMasterList = await db!.getBrandListByCompany(selectedCompanyId);
    for (int i = 0; i < _brandMasterList.length; i++) {
      //_brandList.add(_brandMasterList[i].brandName!);
      brandData[_brandMasterList[i].brandId!.toString()] = _brandMasterList[i].brandName!;
    }
    setState(() {
    });
  }

  getBrandName(brandId){
    var brandName = "";
    if(brandId != ''){
      brandName = brandData[brandId].toString();
    }
    // print(brandName);
    return brandName;
  }

  Future<void> getFormatDataByBrand(brandId) async {
    _formatMasterList = await db!.getFormatListByBrand(brandId);
    // print(_formatMasterList);
    for (int i = 0; i < _formatMasterList.length; i++) {
      //_formatList.add(_formatMasterList[i].formatName!);
      formatData[_formatMasterList[i].formatId!.toString()] = _formatMasterList[i].formatName!;
    }
    setState(() {
    });
  }

  getFormatName(formatId, brandId){
    var formatName = "";
    if(formatId != ''){
      if(formatData.isEmpty){
        getFormatDataByBrand(brandId).whenComplete(() =>
        formatName = formatData[formatId].toString()
        );
      }
      formatName = formatData[formatId].toString();
    }
    //print(formatName);
    return formatName;
  }


  Future<void> getVariantDataByBrandAndFormat(brandId,formatId) async {
    _variantMasterList = await db!.getVariantListByBrandAndFormat(brandId,formatId);
    // print(companyId.text+" "+formatId);
    for (int i = 0; i < _variantMasterList.length; i++) {
      // _variantList.add(_variantMasterList[i].variantName!);
      variantData[_variantMasterList[i].variantId!.toString()] = _variantMasterList[i].variantName!;
    }
    setState(() {
    });
  }

  getVariantName(variantId,brandId,formatId){
    var variantName = "";
    if(variantId != ''){
      if(variantData.isEmpty){
        getVariantDataByBrandAndFormat(brandId, formatId).then((value) =>
        variantName = variantData[variantId].toString()
        );
      }
      variantName = variantData[variantId].toString();
    }
    return variantName;
  }

  Future<void> getWarehouseData(selectedCompanyId) async {
    _warehouseMasterList = await db!.getWarehouseDataByCompany(selectedCompanyId);
    for (int i = 0; i < _warehouseMasterList.length; i++) {
      warehouseData[_warehouseMasterList[i].warehouseId!.toString()] = _warehouseMasterList[i].warehouseName!;
    }
    print(warehouseData);
    setState(() {
    });
  }

  getWarehouseName(warehouseId,companyId){
    var warehouseName = "";
    if(warehouseId != ''){
      if(warehouseData.isEmpty){
        getWarehouseData(companyId).then((value) =>
        warehouseName = warehouseData[warehouseId].toString()
        );
      }else {
        warehouseName = warehouseData[warehouseId].toString();
      }
    }
    return warehouseName;
  }

  Future<void> getDescriptionData(brandId,formatId, variantId) async {
    _descriptionMasterList = await db!.getDescriptionListArray(brandId,formatId,variantId);
    //print(_descriptionMasterList);
    for (int i = 0; i < _descriptionMasterList.length; i++) {
      descriptionData[_descriptionMasterList[i].productId!.toString()] = _descriptionMasterList[i].productName!;
      // _descriptionList.add(_descriptionMasterList[i].productName!);
    }
    setState(() {
    });
  }

  getDescriptionName(productId,brandId,formatId,variantId){
    var productName = "";
    if(productId != ''){
      if(descriptionData.isEmpty){
        getDescriptionData(brandId,formatId,variantId).then((value) =>
        productName = descriptionData[productId].toString()
        );
      }
      productName = descriptionData[productId].toString();
    }
    return productName;
  }

  @override
  Widget build(BuildContext context) {

    final updateAuditEntries = ModalRoute.of(context)!.settings.arguments as AuditEntriesModel;
    companyId.text = selectedCompanyId;
    // brandId.text = updateAuditEntries.brandId!;
    // formatId.text = updateAuditEntries.formatId!;
    // variantId.text = updateAuditEntries.variantId!;
    // descriptionId.text = updateAuditEntries.productId!;
    mfgMonth.text = updateAuditEntries.mfgMonth ?? "";
    mfgYear.text = updateAuditEntries.mfgYear ?? "";
    expMonth.text = updateAuditEntries.expMonth ?? "";
    expYear.text = updateAuditEntries.expYear ?? "";
    //warehouseId.text = updateAuditEntries.warehouseId ?? "";
    weight.text = updateAuditEntries.weight ?? "";
    mrp.text = updateAuditEntries.mrp ?? "";
    valuationPerUnit.text = updateAuditEntries.valuationPerUnit ?? "";
    systemUnit.text = updateAuditEntries.systemUnit ?? "";
    calculation.text = "";
    actualUnits.text = updateAuditEntries.actualUnit ?? "";
    totalValuation.text = updateAuditEntries.totalStockValue ?? "";
    var calc = json.decode(updateAuditEntries.calculationArr ?? "0");
    Map data = {};

    if(calc.isNotEmpty) {
      //print(updateAuditEntries.calculationArr!);
      // Map<String, dynamic> myMap = json.decode(updateAuditEntries.calculationArr!);
      // print(myMap[0]);
      // List<dynamic> entitlements = myMap["Dependents"][0]["Entitlements"];

      // myMap.forEach((entitlement) {
      //   (entitlement as Map<String, dynamic>).forEach((key, value) {
      //     print(key);
      //     (value as Map<String, dynamic>).forEach((key2, value2) {
      //       print(key2);
      //       print(value2);
      //     });
      //   });
      // });
      //  data = json.decode(updateAuditEntries.calculationArr ?? "") ;
      // if(data.length > 0){
      //     for(var item in data.entries) {
      //       _calculationArr.add(item.value);
      //      // print(item.key);
      //     };
      //     // print(_calculationArr);
      // }
    }


    selectedBrand = getBrandName(updateAuditEntries.brandId!);
    selectedFormat = getFormatName(updateAuditEntries.formatId!,updateAuditEntries.brandId!);
    selectedVariant = getVariantName(updateAuditEntries.variantId!, updateAuditEntries.brandId!, updateAuditEntries.formatId!);
    selectedWarehouse = getWarehouseName(updateAuditEntries.warehouseId!, updateAuditEntries.companyId!);
    selectedDescription = getDescriptionName(updateAuditEntries.productId!,updateAuditEntries.brandId!, updateAuditEntries.formatId!,updateAuditEntries.variantId!);
    selectedMfgMonth = updateAuditEntries.mfgMonth!;
    selectedMfgYear = updateAuditEntries.mfgYear!;
    selectedExpMonth = updateAuditEntries.expMonth!;
    selectedExpYear = updateAuditEntries.expYear!;
    recordId = updateAuditEntries.entryId!;


    return Scaffold(
      appBar: appbar(context, 'Update Audit Entries', {'icons' : Icons.menu}),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(constants.bodyPadding),
              child: Column(
                children: [
                  Row(
                    children: [
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
                            setState(() {
                              selectedBrand = val!;
                              brandId.text = key!;
                              formatData.clear();
                              variantData.clear();
                              updateAuditEntries.brandName = val!;
                              getFormatDataByBrand(brandId.text);
                              selectedFormat = "";
                              selectedVariant = "";
                            });
                          },
                          selectedItem: selectedBrand,
                        ),
                      ),
                      SizedBox(width: 10),

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

                            setState(() {
                              selectedFormat = val!;
                              updateAuditEntries.formatName = val!;
                              formatId.text = key!;
                              variantData.clear();
                              getVariantDataByBrandAndFormat(brandId.text, formatId.text);
                              selectedVariant = "";
                            });

                          },
                          selectedItem: selectedFormat,
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
                            setState(() {
                              selectedVariant = val!;
                              updateAuditEntries.variantName = val!;
                              variantId.text = key!;
                              descriptionData.clear();
                              getDescriptionData(brandId.text, formatId.text, variantId.text);
                            });

                          },
                          selectedItem: selectedVariant,
                        ),
                      ),
                      SizedBox(width: 10),

                      Flexible(
                        child: DropdownSearch<String>(
                          popupProps: PopupProps.modalBottomSheet(
                            showSelectedItems: true,
                            //disabledItemFn: (String s) => s.startsWith('I'),
                          ),
                          items: descriptionData.values.toList(),
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelText: "Description",
                              hintText: "Select Description",
                            ),
                          ),
                          onChanged: (val){
                            var key = descriptionData.keys.firstWhere((k)
                            => descriptionData[k] == val!, orElse: () => "");
                            setState(() {
                              selectedDescription = val!;
                              updateAuditEntries.productName = val!;
                              descriptionId.text = key!;
                              var descriptionRecord = db!.getDescriptionRecord(brandId.text, formatId.text, variantId.text, descriptionId.text);
                              // var descriptionData = db.getDescription
                              print(descriptionRecord);
                              if(descriptionRecord == true){
                                // mrp.text = descriptionRecord.mrp;
                              }
                            });
                          },
                          selectedItem: selectedDescription,
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
                          selectedItem: selectedMfgMonth,
                        ),
                      ),
                      SizedBox(width: 10),

                      Flexible(
                        child: DropdownSearch<String>(
                          popupProps: PopupProps.modalBottomSheet(
                            showSelectedItems: true,
                            //disabledItemFn: (String s) => s.startsWith('I'),
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
                          selectedItem: selectedMfgYear,
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
                          selectedItem: selectedExpMonth,
                        ),
                      ),
                      SizedBox(width: 10),

                      Flexible(
                        child: DropdownSearch<String>(
                          popupProps: PopupProps.modalBottomSheet(
                            showSelectedItems: true,
                            //disabledItemFn: (String s) => s.startsWith('I'),
                          ),
                          items: _years,
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelText: "EXP Year",
                              hintText: "Select EXP Year",
                            ),
                          ),
                          onChanged: (val){
                            expYear.text = val!;
                          },
                          selectedItem: selectedExpYear,
                        )
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
    setState(() {
      selectedWarehouse = val!;
      warehouseId.text = key!;
      updateAuditEntries.warehouseName = val!;
    });
                          },
                          selectedItem: selectedWarehouse,
                        ),
                      ),
                      SizedBox(width: 10),

                      Flexible(
                        child: TextField(
                            controller: weight,
                            decoration: InputDecoration(
                                labelText: 'Weight',
                                // border: OutlineInputBorder(
                                //     borderRadius: BorderRadius.circular(11),
                                //     borderSide: BorderSide(
                                //       color: Colors.blue,
                                //     )
                                // ),
                                // prefixIcon: Icon(Icons.list_alt, color: Colors.orange),
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
                            controller: mrp,
                            decoration: InputDecoration(
                                labelText: 'MRP',
                                // border: OutlineInputBorder(
                                //     borderRadius: BorderRadius.circular(11),
                                //     borderSide: BorderSide(
                                //       color: Colors.blue,
                                //     )
                                // ),
                                // prefixIcon: Icon(Icons.list_alt, color: Colors.orange),
                              contentPadding: EdgeInsets.symmetric(vertical: 15),

                            )
                        ),
                      ),
                      SizedBox(width: 10),

                      Flexible(
                        child: TextField(
                            controller: valuationPerUnit,
                            decoration: InputDecoration(
                                labelText: 'Valuation Per Unit',
                                // border: OutlineInputBorder(
                                //     borderRadius: BorderRadius.circular(11),
                                //     borderSide: BorderSide(
                                //       color: Colors.blue,
                                //     )
                                // ),
                                // prefixIcon: Icon(Icons.list_alt, color: Colors.orange),
                              contentPadding: EdgeInsets.symmetric(vertical: 15),

                            )
                        ),
                      ),
                    ],
                  ),

                  Container(height: 11),
                  TextField(
                      controller: systemUnit,
                      decoration: InputDecoration(
                          labelText: 'System Unit',
                          // border: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(11),
                          //     borderSide: BorderSide(
                          //       color: Colors.blue,
                          //     )
                          // ),
                          // prefixIcon: Icon(Icons.list_alt, color: Colors.orange),
                        contentPadding: EdgeInsets.symmetric(vertical: 15),

                      )
                  ),
                  Container(height: 11),
                  Row(
                    children: [
                      Flexible(
                        child: TextField(
                          controller: calculation,
                          decoration: InputDecoration(
                            labelText: 'Calculation',
                            // border: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(11),
                            //     borderSide: BorderSide(
                            //       color: Colors.blue,
                            //     )
                            // ),
                            // prefixIcon: Icon(Icons.list_alt, color: Colors.orange),
                            contentPadding: EdgeInsets.symmetric(vertical: 15),

                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: ElevatedButton(onPressed: (){
                          var calculations = calculation.text;
                          double calculationResult = 0;
                          if(calculations != '') {
                            Parser expression = Parser();
                            Expression calcActualUnit = expression.parse(
                                calculations);
                            ContextModel cm = ContextModel();
                            calculationResult = calcActualUnit.evaluate(EvaluationType.REAL,cm);
                            //print(calculationResult);
                          }

                          if(actualUnits.text != ''){
                            existingActualUnits = double.parse(actualUnits.text);
                          }
                         // print(existingActualUnits);
                          actualUnits.text = (existingActualUnits + calculationResult).toString();
                          if(calculations != ''){
                            totalValuation.text = (double.parse(actualUnits.text) * double.parse(valuationPerUnit.text)).toStringAsFixed(2);
                            calc.add(calculations);
                          }
                          print(json.encode(calc));
                          calculation.text = "";
                        }, child: Text(
                            'Calculate'
                        )),
                      ),
                    ],
                  ),
                  Container(height: 11),
                  Row(
                    children: [
                      Flexible(
                        child: TextField(
                            controller: actualUnits,
                            decoration: InputDecoration(
                                labelText: 'Actual Units',
                                // border: OutlineInputBorder(
                                //     borderRadius: BorderRadius.circular(11),
                                //     borderSide: BorderSide(
                                //       color: Colors.blue,
                                //     )
                                // ),
                                // prefixIcon: Icon(Icons.list_alt, color: Colors.orange),
                              contentPadding: EdgeInsets.symmetric(vertical: 15),

                            )
                        ),
                      ),
                      SizedBox(width: 10),

                      Flexible(
                        child: TextField(
                            controller: totalValuation,
                            decoration: InputDecoration(
                                labelText: 'Total Valuation',
                                // border: OutlineInputBorder(
                                //     borderRadius: BorderRadius.circular(11),
                                //     borderSide: BorderSide(
                                //       color: Colors.blue,
                                //     )
                                // ),
                                // prefixIcon: Icon(Icons.list_alt, color: Colors.orange),
                              contentPadding: EdgeInsets.symmetric(vertical: 15),

                            )
                        ),
                      ),
                    ],
                  ),

                  // Container(height: 20),
                  // DropdownButton(
                  //     value: selectedItem, items: statusDropdown.map((e) {
                  //   return DropdownMenuItem(value: e,child: Text(e));
                  // }).toList(), onChanged: (val){
                  //   setState(() {
                  //     selectedItem = val as String;
                  //   });
                  // }),
                  Container(height: 40),
                  SizedBox(
                    width: constants.buttonWidth,
                    height: constants.buttonHeight,
                    child: ElevatedButton(onPressed: (){
                      String uBrand = brandId.text.toString();
                      String uFormat = formatId.text.toString();
                      String uVariant = variantId.text.toString();
                      String uDescription = descriptionId.text.toString();
                      String uMfgMonth = mfgMonth.text.toString();
                      String uMfgYear = mfgYear.text.toString();
                      String uExpMonth = mfgMonth.text.toString();
                      String uExpYear = expYear.text.toString();
                      String uWarehouse = warehouseId.text.toString();
                      String uWeight = weight.text.toString();
                      String uMrp = mrp.text.toString();
                      String uValuationPerUnit = valuationPerUnit.text.toString();
                      String uSystemUnit = systemUnit.text.toString();
                      String uCalculation = json.encode(calc);
                      String uActualUnit = actualUnits.text.toString();
                      String uTotalValuation = totalValuation.text.toString();

                      //print("actual units are $uActualUnit");
                      if(uBrand == ''){
                        uBrand = updateAuditEntries.brandId.toString();
                      }
                      if(uFormat == ''){
                        uFormat = updateAuditEntries.formatId.toString();
                      }
                      if(uVariant == ''){
                        uVariant = updateAuditEntries.variantId.toString();
                      }
                      if(uDescription == ''){
                        uDescription = updateAuditEntries.productId.toString();
                      }
                      if(uMfgMonth == ''){
                        uMfgMonth = updateAuditEntries.mfgMonth.toString();
                      }
                      if(uMfgYear == ''){
                        uMfgYear = updateAuditEntries.mfgYear.toString();
                      }
                      if(uExpMonth == ''){
                        uExpMonth = updateAuditEntries.expMonth.toString();
                      }
                      if(uExpYear == ''){
                        uExpYear = updateAuditEntries.expYear.toString();
                      }
                      if(uWarehouse == ''){
                        uWarehouse = updateAuditEntries.warehouseId.toString();
                      }

                      //print(uFormat);
                      dbHelper!.update(
                          AuditEntriesModel(
                            companyId: selectedCompanyId,
                            entryId: recordId,
                        brandId: uBrand,
                        formatId: uFormat,
                            variantId: uVariant,
                            productId: uDescription,
                            mfgMonth: uMfgMonth,
                            mfgYear: uMfgYear,
                            expMonth: uExpMonth,
                            expYear: uExpYear,
                            warehouseId: uWarehouse,
                            weight: uWeight,
                            mrp: uMrp,
                            valuationPerUnit: uValuationPerUnit,
                            systemUnit: uSystemUnit,
                            calculationArr: uCalculation,
                            actualUnit: uActualUnit,
                            totalStockValue: uTotalValuation,
                            productName: updateAuditEntries.productName,
                            brandName: updateAuditEntries.brandName,
                            formatName: updateAuditEntries.formatName,
                            variantName: updateAuditEntries.variantName,
                            warehouseName: updateAuditEntries.warehouseName,
                          )
                      ).then((value) {
                        constants.Notification("Audit Entry Updated Successfully");
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => AuditEntries(auditCompanyId: selectedCompanyId)));
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
            )
        ),
      ),
    );
  }
}