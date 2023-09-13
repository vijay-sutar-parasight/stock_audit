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
  UpdateAuditEntries({required this.selectedCompanyId});
  @override
  State<UpdateAuditEntries> createState() => _UpdateAuditEntries(selectedCompanyId);
}

class _UpdateAuditEntries extends State<UpdateAuditEntries>{

  String selectedCompanyId;
  double existingActualUnits = 0;
  _UpdateAuditEntries(this.selectedCompanyId);
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
    print(selectedCompanyId);
    _brandMasterList = await db!.getBrandListByCompany(selectedCompanyId);
    for (int i = 0; i < _brandMasterList.length; i++) {
      _brandList.add(_brandMasterList[i].brandName!);
      setState(() {
      });
    }
  }

  Future<void> getFormatDataByBrand(brandId) async {
    _formatMasterList = await db!.getFormatListByBrand(brandId);
    print(_formatMasterList);
    for (int i = 0; i < _formatMasterList.length; i++) {
      _formatList.add(_formatMasterList[i].formatName!);
      setState(() {
      });
    }
  }

  Future<void> getVariantDataByBrandAndFormat(brandId,formatId) async {
    _variantMasterList = await db!.getVariantListByBrandAndFormat(brandId,formatId);
    print(brandId);
    for (int i = 0; i < _variantMasterList.length; i++) {
      _variantList.add(_variantMasterList[i].variantName!);
      setState(() {
      });
    }
  }

  Future<void> getWarehouseData(selectedCompanyId) async {
    _warehouseMasterList = await db!.getWarehouseDataByCompany(selectedCompanyId);
    for (int i = 0; i < _warehouseMasterList.length; i++) {
      _warehouseList.add(_warehouseMasterList[i].warehouseName!);
      setState(() {

      });
    }
  }

  Future<void> getDescriptionData(brandId,formatId, variantId) async {
    _descriptionMasterList = await db!.getDescriptionListArray(brandId,formatId,variantId);
    print(_descriptionMasterList);
    for (int i = 0; i < _descriptionMasterList.length; i++) {
      _descriptionList.add(_descriptionMasterList[i].productName!);
      setState(() {
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final updateAuditEntries = ModalRoute.of(context)!.settings.arguments as AuditEntriesModel;
    companyId.text = selectedCompanyId;
    // brandId.text = updateAuditEntries.brandId!;
    // formatId.text = updateAuditEntries.formatId!;
    // variantId.text = updateAuditEntries.variantId!;
    // descriptionId.text = updateAuditEntries.productId!;
    mfgMonth.text = updateAuditEntries.mfgMonth!;
    mfgYear.text = updateAuditEntries.mfgYear!;
    expMonth.text = updateAuditEntries.expMonth!;
    expYear.text = updateAuditEntries.expYear!;
    warehouseId.text = updateAuditEntries.warehouseId!;
    weight.text = updateAuditEntries.weight!;
    mrp.text = updateAuditEntries.mrp!;
    valuationPerUnit.text = updateAuditEntries.valuationPerUnit!;
    systemUnit.text = updateAuditEntries.systemUnit!;
    calculation.text = "";
    var jsonString = jsonDecode(updateAuditEntries.calculationArr!);
    actualUnits.text = updateAuditEntries.actualUnit!;
    totalValuation.text = updateAuditEntries.totalStockValue!;
    print(jsonString);

    recordId = updateAuditEntries.entryId!;

    return Scaffold(
      appBar: appbar(context, 'Update Audit Entries', {'icons' : Icons.menu}),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: DropdownSearch<String>(
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
                        selectedItem: updateAuditEntries.brandId,
                      ),
                    ),
                    SizedBox(width: 10),

                    Flexible(
                      child: DropdownSearch<String>(
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
                          _variantList.clear();
                          getVariantDataByBrandAndFormat(brandId.text, val);
                        },
                        selectedItem: updateAuditEntries.formatId,
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
                        items: _variantList,
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            labelText: "Variant",
                            hintText: "Select Variant",
                          ),
                        ),
                        onChanged: (val){
                          variantId.text = val!;
                          _descriptionList.clear();
                          getDescriptionData(brandId.text, formatId.text, val);
                        },
                        selectedItem: updateAuditEntries.variantId,
                      ),
                    ),
                    SizedBox(width: 10),

                    Flexible(
                      child: DropdownSearch<String>(
                        popupProps: PopupProps.modalBottomSheet(
                          showSelectedItems: true,
                          disabledItemFn: (String s) => s.startsWith('I'),
                        ),
                        items: _descriptionList,
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            labelText: "Description",
                            hintText: "Select Description",
                          ),
                        ),
                        onChanged: (val){
                          descriptionId.text = val!;
                          var descriptionRecord = db!.getDescriptionRecord(brandId.text, formatId.text, variantId.text, descriptionId.text);
                          // var descriptionData = db.getDescription
                          print(descriptionRecord);
                          if(descriptionRecord == true){
                            // mrp.text = descriptionRecord.mrp;
                          }

                        },
                        selectedItem: updateAuditEntries.productId,
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
                          disabledItemFn: (String s) => s.startsWith('I'),
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
                        selectedItem: updateAuditEntries.mfgMonth,
                      ),
                    ),
                    SizedBox(width: 10),

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
                        selectedItem: updateAuditEntries.mfgYear,
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
                        selectedItem: updateAuditEntries.expMonth,
                      ),
                    ),
                    SizedBox(width: 10),

                    Flexible(
                      child: DropdownSearch<String>(
                        popupProps: PopupProps.modalBottomSheet(
                          showSelectedItems: true,
                          disabledItemFn: (String s) => s.startsWith('I'),
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
                        selectedItem: updateAuditEntries.expYear,
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
                          disabledItemFn: (String s) => s.startsWith('I'),
                        ),
                        items: _warehouseList,
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            labelText: "Warehouse",
                            hintText: "Select Warehouse",
                          ),
                        ),
                        onChanged: (val){
                          warehouseId.text = val!;
                        },
                        selectedItem: updateAuditEntries.warehouseId,
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
                Row(
                  children: [
                    Flexible(
                      child: TextField(
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
                    ),
                    SizedBox(width: 10),

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
                  ],
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
                        controller: calculation,
                        decoration: InputDecoration(
                          hintText: 'Calculation',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11),
                              borderSide: BorderSide(
                                color: Colors.blue,
                              )
                          ),
                          prefixIcon: Icon(Icons.list_alt, color: Colors.orange),
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
                          print(calculationResult);
                        }

                        if(actualUnits.text != ''){
                          existingActualUnits = double.parse(actualUnits.text);
                        }
                        print(existingActualUnits);
                        actualUnits.text = (existingActualUnits + calculationResult).toString();
                        if(calculations != ''){
                          _calculationArr.add(calculations);
                        }
                        print(_calculationArr);
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
                              hintText: 'Actual Units',
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
                          controller: totalValuation,
                          decoration: InputDecoration(
                              hintText: 'Total Valuation',
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
                //   return DropdownMenuItem(value: e,child: Text(e));
                // }).toList(), onChanged: (val){
                //   setState(() {
                //     selectedItem = val as String;
                //   });
                // }),
                Container(height: 20),
                ElevatedButton(onPressed: (){
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
                  String uCalculation = calculation.text.toString();
                  String uActualUnit = actualUnits.text.toString();
                  String uTotalValuation = totalValuation.text.toString();

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
                        productName: uDescription,
                        brandName: uBrand,
                        formatName: uFormat,
                        variantName: uVariant,
                        warehouseName: uWarehouse,
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
                ))
              ],
            )
        ),
      ),
    );
  }
}