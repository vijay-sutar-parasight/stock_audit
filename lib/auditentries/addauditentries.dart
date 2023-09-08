import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stock_audit/db_handler.dart';
import 'package:stock_audit/util/constants.dart' as constants;

import '../../models/auditentriesmodel.dart';
import '../appbar.dart';
import '../jsondata/GetBrandData.dart';
import '../jsondata/GetCompanyData.dart';
import '../jsondata/GetDescriptionData.dart';
import '../jsondata/GetFormatData.dart';
import '../jsondata/GetVariantData.dart';
import '../jsondata/GetWarehouseData.dart';
import 'auditentries.dart';
import 'auditentries_handler.dart';

class AddAuditEntries extends StatefulWidget{
  @override

  String selectedCompanyId;
  AddAuditEntries({required this.selectedCompanyId});
  State<AddAuditEntries> createState() => _AddAuditEntries(selectedCompanyId);

}

class _AddAuditEntries extends State<AddAuditEntries>{

  String selectedCompanyId;
  _AddAuditEntries(this.selectedCompanyId);

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
  List _calculations = [];


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
    print(_variantMasterList);
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
    return Scaffold(
      appBar: appbar(context, 'Add Audit Entries', {'icons' : Icons.menu}),
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
                        items: _descriptionList,
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            labelText: "Description",
                            hintText: "Select Description",
                          ),
                        ),
                        onChanged: (val){
                          descriptionId.text = val!;

                          // var descriptionData = db.getDescription

                        },
                        selectedItem: "",
                      ),
                    ),
                  ],
                ),
                Container(height: 11),
                
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
                TextField(
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
                  String uCompanyId = selectedCompanyId;
                  String uBrand = brandId.text.toString();
                  String uFormat = formatId.text.toString();
                  String uVariant = variantId.text.toString();
                  String uDescriiption = descriptionId.text.toString();
                  String uMfgMonth = mfgMonth.text.toString();
                  String uMfgYear = mfgYear.text.toString();
                  String uExpMonth = expMonth.text.toString();
                  String uExpYear = expYear.text.toString();
                  String uWarehouse = warehouseId.text.toString();
                  String uWeight = weight.text.toString();
                  String uMrp = mrp.text.toString();
                  String uValuationPerUnit = valuationPerUnit.text.toString();
                  String uSystemUnit = systemUnit.text.toString();
                  String uCalculation = jsonEncode(calculation);
                  String uActualUnit = actualUnits.text.toString();
                  String uTotalValuation = totalValuation.text.toString();
                  dbHelper!.insert(
                      AuditEntriesModel(
                        companyId: selectedCompanyId,
                    brandId: uBrand,
                    formatId: uFormat,
                        variantId: uVariant,
                        productId: uDescriiption,
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
                        productName: uDescriiption,
                        brandName: uBrand,
                        formatName: uFormat,
                        variantName: uVariant,
                        warehouseName: uWarehouse,
                      )
                  ).then((value) {
                    constants.Notification("Audit Entry Added Successfully");
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => AuditEntries(auditCompanyId: selectedCompanyId.toString())));
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