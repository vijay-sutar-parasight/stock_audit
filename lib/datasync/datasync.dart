import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_audit/db_handler.dart';
import 'package:stock_audit/jsondata/GetAuditEntriesData.dart';
import 'package:stock_audit/jsondata/GetBrandData.dart';
import 'package:stock_audit/jsondata/GetCompanyData.dart';
import 'package:stock_audit/jsondata/GetDescriptionData.dart';
import 'package:stock_audit/jsondata/GetVariantData.dart';
import 'package:stock_audit/util/constants.dart' as constants;
import 'package:http/http.dart' as http;

import '../appbar.dart';
import '../jsondata/GetAuditData.dart';
import '../jsondata/GetFormatData.dart';
import '../jsondata/GetWarehouseData.dart';
import '../models/brandmodel.dart';


class DataSync extends StatefulWidget{
  @override
  State<DataSync> createState() => _DataSyncState();
}

class _DataSyncState extends State<DataSync> {
  bool brands = true;

  bool formats = true;

  bool variants = true;

  bool descriptions = true;

  bool warehouses = true;

  bool audit = true;
  bool company = true;

  DBHelper? dbHelper;
  String _brandList = "";
  String _formatList = "";
  String _variantList = "";
  String _descriptionList = "";
  String _warehouseList = "";
  String _auditList = "";
  String _auditEntriesList = "";
  String _companyList = "";

  List<GetBrandData> _brandMasterList = [];
  List<GetFormatData> _formatMasterList = [];
  List<GetVariantData> _variantMasterList = [];
  List<GetCompanyData> _companyMasterList = [];
  List<GetDescriptionData> _descriptionMasterList = [];
  List<GetWarehouseData> _warehouseMasterList = [];
  List<GetAuditData> _auditMasterList = [];
  List<GetAuditEntriesData> _auditEntriesMasterList = [];

  String lastSyncDate = "Not Synced Yet!";

  @override
  void initState(){
    super.initState();
    dbHelper = DBHelper();
  }

    getSyncDate(){
      dbHelper!.getLastSyncDate().then((value) => {
        lastSyncDate = value
      });
    }

    Future<void> getBrandData() async {
      _brandMasterList = await dbHelper!.getBrandListArray();
      _brandList = jsonEncode(_brandMasterList);
    }
  Future<void> getFormatData() async {
    _formatMasterList = await dbHelper!.getFormatListArray();
    _formatList = jsonEncode(_formatMasterList);
  }
  Future<void> getVariantData() async {
    _variantMasterList = await dbHelper!.getVariantListArray();
    _variantList = jsonEncode(_variantMasterList);
  }
  Future<void> getWarehouseData() async {
    _warehouseMasterList = await dbHelper!.getWarehouseListArray();
    _warehouseList = jsonEncode(_warehouseMasterList);
  }
  Future<void> getCompanyData() async {
    _companyMasterList = await dbHelper!.getCompanyListArray();
    _companyList = jsonEncode(_companyMasterList);
  }
  Future<void> getDescriptionData() async {
    _descriptionMasterList = await dbHelper!.getDescriptionListRecords();
    _descriptionList = jsonEncode(_descriptionMasterList);
  }
  Future<void> getAuditData() async {
    _auditMasterList = await dbHelper!.getAuditListArray();
    _auditList = jsonEncode(_auditMasterList);
  }
  Future<void> getAuditEntriesData() async {
    _auditEntriesMasterList = await dbHelper!.getAuditEntriesListArray();
    _auditEntriesList = jsonEncode(_auditEntriesMasterList);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context, 'Data Sync', {'icons' : Icons.menu}),
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(28.0),
          child: Text("Last Sync Date: $lastSyncDate", style: TextStyle(color: Colors.black),),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Flexible(
              child: ElevatedButton(onPressed: (){
                dbHelper!.syncDatabase();
              }, child: Text(
                  'Import From Server'
              )),
            ),
            SizedBox(width: 20,),
            Flexible(
              child: ElevatedButton(onPressed: () async {
                getBrandData();
                getCompanyData();
                getFormatData();
                getVariantData();
                getWarehouseData();
                getDescriptionData();
                getAuditData();
                getAuditEntriesData();
                var dataPayload = {
                    'brand' : _brandList,
                    'company' : _companyList,
                    'format' : _formatList,
                    'variant' : _variantList,
                    'warehouse' : _warehouseList,
                    'description' : _descriptionList,
                    'audit' : _auditList,
                    'audit_entries' : _auditEntriesList,
                  };
                  String url = "${constants.apiBaseURL}/synchronizedata";
                  final response = await http.post(Uri.parse(url),body: dataPayload);
                print(response.body);


              }, child: Text(
                  'Sync To Server'
              )),
            )
          ],
        ),
        

      ],
    )
    );
  }
}