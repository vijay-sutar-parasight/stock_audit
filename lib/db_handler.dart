import 'dart:convert';
import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stock_audit/auditentries/auditentries_handler.dart';
import 'package:stock_audit/jsondata/GetAuditEntriesData.dart';
import 'package:stock_audit/jsondata/GetCompanyData.dart';
import 'package:stock_audit/jsondata/GetWarehouseData.dart';
import 'package:stock_audit/models/auditmodel.dart';
import 'package:path/path.dart';
import 'package:stock_audit/models/syncdate.dart';
import 'dart:io' as io;
import 'package:stock_audit/util/constants.dart' as constants;

import 'jsondata/GetAuditData.dart';
import 'jsondata/GetBrandData.dart';
import 'jsondata/GetDescriptionData.dart';
import 'jsondata/GetFormatData.dart';
import 'jsondata/GetVariantData.dart';
import 'models/adminusers.dart';
import 'models/auditentriesmodel.dart';
import 'models/brandmodel.dart';
import 'models/companymodel.dart';
import 'models/formatmodel.dart';
import 'models/productmodel.dart';
import 'models/variantmodel.dart';
import 'models/warehousemodel.dart';
import 'package:http/http.dart' as http;

class DBHelper{
  static Database? _db;

  Future<Database?> get db async{
    if(_db != null){
      return _db!;
    }
    _db = await initDatabase();
    return _db!;
  }

  initDatabase() async{
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, '${constants.apiBaseURL}');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate,onConfigure: _onConfigure);
    return db;
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  _onCreate (Database db, int version) async{
    await db.execute("CREATE TABLE IF NOT EXISTS admin_users (admin_user_id INTEGER PRIMARY KEY AUTOINCREMENT, first_name TEXT NULL, last_name TEXT NULL, email TEXT NULL, password TEXT NULL, mobile_no TEXT NULL)");
    await db.execute("CREATE TABLE IF NOT EXISTS company (company_id INTEGER PRIMARY KEY AUTOINCREMENT, company_name TEXT NULL, company_address TEXT NULL, cm_mobile TEXT NULL, city TEXT NULL)");
    await db.execute("CREATE TABLE IF NOT EXISTS brand (brand_id INTEGER PRIMARY KEY AUTOINCREMENT, brand_name TEXT NULL, company_id TEXT NULL)");
    await db.execute("CREATE TABLE IF NOT EXISTS format (format_id INTEGER PRIMARY KEY AUTOINCREMENT, format_name TEXT NULL, brand_id TEXT NULL)");
    await db.execute("CREATE TABLE IF NOT EXISTS variant (variant_id INTEGER PRIMARY KEY AUTOINCREMENT, brand_id TEXT NULL, variant_name TEXT NULL, format_id TEXT NULL)");
    await db.execute("CREATE TABLE IF NOT EXISTS warehouse (warehouse_id INTEGER PRIMARY KEY AUTOINCREMENT, warehouse_name TEXT NULL, company_id TEXT NULL)");
    await db.execute("CREATE TABLE IF NOT EXISTS product (product_id INTEGER PRIMARY KEY AUTOINCREMENT, product_name TEXT NULL, item_number TEXT NULL, company_id TEXT NULL, format_id TEXT NULL, variant_id TEXT NULL, brand_id TEXT NULL, warehouse_id TEXT NULL, system_unit TEXT NULL, valuation_per_unit TEXT NULL, weight TEXT NULL, mrp TEXT NULL, combi_type TEXT NULL, pcs_cases TEXT NULL, total_stock_value TEXT NULL, mfg_date TEXT NULL, mfg_month TEXT NULL, mfg_year TEXT NULL, exp_date TEXT NULL, exp_month TEXT NULL, exp_year TEXT NULL)");
    await db.execute("CREATE TABLE IF NOT EXISTS audit (audit_id INTEGER PRIMARY KEY AUTOINCREMENT, company_id TEXT NULL, audit_description TEXT NULL, audit_status TEXT NULL)");
    await db.execute("CREATE TABLE IF NOT EXISTS audit_wise_entries (entry_id INTEGER PRIMARY KEY AUTOINCREMENT, audit_id TEXT NULL, company_id TEXT NULL, product_id TEXT NULL, brand_id TEXT NULL, format_id TEXT NULL, variant_id TEXT NULL, warehouse_id TEXT NULL, user_id TEXT NULL, admin_user_name TEXT NULL, mfg_month TEXT NULL, mfg_year TEXT NULL, exp_month TEXT NULL, exp_year TEXT NULL, actual_unit TEXT NULL, system_unit TEXT NULL, weight TEXT NULL, mrp TEXT NULL,  valuation_per_unit TEXT NULL, total_amount TEXT NULL, factor_1 TEXT NULL,  oprator TEXT NULL, factor_2 TEXT NULL, calculation_arr TEXT NULL, city TEXT NULL, product_name TEXT NULL, company_name TEXT NULL, brand_name TEXT NULL, format_name TEXT NULL, variant_name TEXT NULL, warehouse_name TEXT NULL, combi_type TEXT NULL, pcs_cases TEXT NULL, total_stock_value TEXT NULL, mfg_date TEXT NULL, exp_date TEXT NULL, created_at TEXT NULL, updated_at TEXT NULL, deleted_at TEXT NULL)");
    await db.execute("CREATE TABLE IF NOT EXISTS sync_date (sync_id INTEGER PRIMARY KEY AUTOINCREMENT, sync_code TEXT NULL, sync_date TEXT NULL)");
  }

  Future<SyncDate> insertSyncdate(SyncDate syncDate) async{
    var dbClient = await db;
    await dbClient!.insert('sync_date', syncDate.toMap());
    return syncDate;
  }

  Future<AuditModel> insert(AuditModel auditModel) async{
    var dbClient = await db;
    await dbClient!.insert('audit', auditModel.toMap());
    return auditModel;
  }

  Future<List<AuditModel>> getAuditList() async{
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient!.query("audit");
    return queryResult.map((e) => AuditModel.fromMap(e)).toList();
  }

  Future<List<GetAuditData>> getAuditListArray() async {
    var dbClient = await db;
    final res = await dbClient!.rawQuery("SELECT * FROM audit");
    List<GetAuditData> list =
    res.isNotEmpty ? res.map((c) => GetAuditData.fromJson(c)).toList() : [];
    return list;
  }

  Future<int> delete(int auditId) async{
    var dbClient = await db;
    return await dbClient!.delete(
      'audit',
      where: 'audit_id=?',
      whereArgs: [auditId]
    );
  }

  Future<int> update(AuditModel auditModel) async{
    var dbClient = await db;
    return await dbClient!.update(
        'audit',
        auditModel.toMap(),
        where: 'audit_id=?',
        whereArgs: [auditModel.auditId]
    );
  }


  Future<List<GetAuditEntriesData>> getAuditEntriesListArray() async {
    var dbClient = await db;
    final res = await dbClient!.rawQuery("SELECT * FROM audit_wise_entries");
    List<GetAuditEntriesData> list =
    res.isNotEmpty ? res.map((c) => GetAuditEntriesData.fromJson(c)).toList() : [];
    return list;
  }


  Future<BrandModel> insertBrand(BrandModel brandModel) async{
    var dbClient = await db;
    await dbClient!.insert('brand', brandModel.toMap());
    return brandModel;
  }

  Future<List<BrandModel>> getBrandList() async{
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient!.query("brand");
    //print(queryResult);
    return queryResult.map((e) => BrandModel.fromMap(e)).toList();
  }

  Future<List<GetBrandData>> getBrandListArray() async {
    var dbClient = await db;
    final res = await dbClient!.rawQuery("SELECT * FROM brand");
    List<GetBrandData> list =
    res.isNotEmpty ? res.map((c) => GetBrandData.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<GetBrandData>> getBrandListByCompany(var companyId) async {
    var dbClient = await db;
    // print(companyId);
    final res = await dbClient!.rawQuery("SELECT * FROM brand where company_id='$companyId'");
    List<GetBrandData> list =
    res.isNotEmpty ? res.map((c) => GetBrandData.fromJson(c)).toList() : [];
    return list;
  }

  Future<int> deleteBrand(int brandId) async{
    var dbClient = await db;
    return await dbClient!.delete(
        'brand',
        where: 'brand_id=?',
        whereArgs: [brandId]
    );
  }

  Future<int> updateBrand(BrandModel brandModel) async{
    var dbClient = await db;
    return await dbClient!.update(
        'brand',
        brandModel.toMap(),
        where: 'brand_id=?',
        whereArgs: [brandModel.brandId]
    );
  }


  Future<FormatModel> insertFormat(FormatModel formatModel) async{
    var dbClient = await db;
    await dbClient!.insert('format', formatModel.toMap());
    return formatModel;
  }

  Future<List<FormatModel>> getFormatList() async{
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient!.query("format");
    return queryResult.map((e) => FormatModel.fromMap(e)).toList();
  }

  Future<List<GetFormatData>> getFormatListArray() async {
    var dbClient = await db;
    final res = await dbClient!.rawQuery("SELECT * FROM format");
    List<GetFormatData> list =
    res.isNotEmpty ? res.map((c) => GetFormatData.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<GetFormatData>> getFormatListByBrand(var brandId) async {
    var dbClient = await db;
    // print("SELECT * FROM format where brand_id='$brandId'");
    final res = await dbClient!.rawQuery("SELECT * FROM format where brand_id='$brandId'");
    List<GetFormatData> list =
    res.isNotEmpty ? res.map((c) => GetFormatData.fromJson(c)).toList() : [];
    return list;
  }

  Future<int> deleteFormat(int formatId) async{
    var dbClient = await db;
    return await dbClient!.delete(
        'format',
        where: 'format_id=?',
        whereArgs: [formatId]
    );
  }

  Future<int> updateFormat(FormatModel formatModel) async{
    var dbClient = await db;
    return await dbClient!.update(
        'format',
        formatModel.toMap(),
        where: 'format_id=?',
        whereArgs: [formatModel.formatId]
    );
  }

  Future<VariantModel> insertVariant(VariantModel variantModel) async{
    var dbClient = await db;
    await dbClient!.insert('variant', variantModel.toMap());
    return variantModel;
  }

  Future<List<VariantModel>> getVariantList() async{
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient!.query("variant");
    return queryResult.map((e) => VariantModel.fromMap(e)).toList();
  }

  Future<List<GetVariantData>> getVariantListArray() async {
    var dbClient = await db;
    final res = await dbClient!.rawQuery("SELECT * FROM variant");
    List<GetVariantData> list =
    res.isNotEmpty ? res.map((c) => GetVariantData.fromJson(c)).toList() : [];
    return list;
  }


  Future<List<GetVariantData>> getVariantListByBrandAndFormat(var brandId, var formatId) async {
    var dbClient = await db;
    // print("SELECT * FROM format where brand_id='$brandId'");
    final res = await dbClient!.rawQuery("SELECT * FROM variant where brand_id='$brandId' and format_id='$formatId'");
    List<GetVariantData> list =
    res.isNotEmpty ? res.map((c) => GetVariantData.fromJson(c)).toList() : [];
    return list;
  }

  Future<int> deleteVariant(int variantId) async{
    var dbClient = await db;
    return await dbClient!.delete(
        'variant',
        where: 'variant_id=?',
        whereArgs: [variantId]
    );
  }

  Future<int> updateVariant(VariantModel variantModel) async{
    var dbClient = await db;
    return await dbClient!.update(
        'variant',
        variantModel.toMap(),
        where: 'variant_id=?',
        whereArgs: [variantModel.variantId]
    );
  }


  Future<WarehouseModel> insertWarehouse(WarehouseModel warehouseModel) async{
    var dbClient = await db;
    await dbClient!.insert('warehouse', warehouseModel.toMap());
    return warehouseModel;
  }

  Future<List<WarehouseModel>> getWarehouseList() async{
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient!.query("warehouse");
    return queryResult.map((e) => WarehouseModel.fromMap(e)).toList();
  }

  Future<List<GetWarehouseData>> getWarehouseListArray() async {
    var dbClient = await db;
    final res = await dbClient!.rawQuery("SELECT * FROM warehouse");
    List<GetWarehouseData> list =
    res.isNotEmpty ? res.map((c) => GetWarehouseData.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<GetWarehouseData>> getWarehouseDataByCompany(var companyId) async {
    var dbClient = await db;
    // print("SELECT * FROM format where brand_id='$brandId'");
    final res = await dbClient!.rawQuery("SELECT * FROM warehouse where company_id='$companyId'");
    List<GetWarehouseData> list =
    res.isNotEmpty ? res.map((c) => GetWarehouseData.fromJson(c)).toList() : [];
    return list;
  }

  Future<int> deleteWarehouse(int warehouseId) async{
    var dbClient = await db;
    return await dbClient!.delete(
        'warehouse',
        where: 'warehouse_id=?',
        whereArgs: [warehouseId]
    );
  }

  Future<int> updateWarehouse(WarehouseModel warehouseModel) async{
    var dbClient = await db;
    return await dbClient!.update(
        'warehouse',
        warehouseModel.toMap(),
        where: 'warehouse_id=?',
        whereArgs: [warehouseModel.warehouseId]
    );
  }

  Future<ProductModel> insertProduct(ProductModel productModel) async{
    var dbClient = await db;
    await dbClient!.insert('product', productModel.toMap());
    return productModel;
  }

  Future<List<ProductModel>> getProductList() async{
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient!.query("product");
    return queryResult.map((e) => ProductModel.fromMap(e)).toList();
  }

  Future<List<GetDescriptionData>> getDescriptionListRecords() async {
    var dbClient = await db;
    final res = await dbClient!.rawQuery("SELECT * FROM product");
    List<GetDescriptionData> list =
    res.isNotEmpty ? res.map((c) => GetDescriptionData.fromJson(c)).toList() : [];
    return list;
  }

  Future<int> deleteProduct(int productId) async{
    var dbClient = await db;
    return await dbClient!.delete(
        'product',
        where: 'product_id=?',
        whereArgs: [productId]
    );
  }

  Future<int> updateProduct(ProductModel productModel) async{
    var dbClient = await db;
    return await dbClient!.update(
        'product',
        productModel.toMap(),
        where: 'product_id=?',
        whereArgs: [productModel.productId]
    );
  }

  Future<CompanyModel> insertCompany(CompanyModel companyModel) async{
    var dbClient = await db;
    await dbClient!.insert('company', companyModel.toMap());
    return companyModel;
  }

  Future<List<CompanyModel>> getCompanyList() async{
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient!.query("company");
    return queryResult.map((e) => CompanyModel.fromMap(e)).toList();
  }

  Future<List<GetCompanyData>> getCompanyListArray() async {
    var dbClient = await db;
    final res = await dbClient!.rawQuery("SELECT * FROM company");
    List<GetCompanyData> list =
    res.isNotEmpty ? res.map((c) => GetCompanyData.fromJson(c)).toList() : [];
    return list;
  }

  Future<int> deleteCompany(int companyId) async{
    var dbClient = await db;
    return await dbClient!.delete(
        'company',
        where: 'company_id=?',
        whereArgs: [companyId]
    );
  }

  Future<int> updateCompany(CompanyModel companyModel) async{
    var dbClient = await db;
    return await dbClient!.update(
        'company',
        companyModel.toMap(),
        where: 'company_id=?',
        whereArgs: [companyModel.companyId]
    );
  }

  Future<List<GetDescriptionData>> getDescriptionListArray(var brandId, var formatId, var variantId) async {
    var dbClient = await db;
    final res = await dbClient!.rawQuery("SELECT * FROM product where brand_id='$brandId' and format_id='$formatId' and variant_id='$variantId'");
    List<GetDescriptionData> list =
    res.isNotEmpty ? res.map((c) => GetDescriptionData.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<GetDescriptionData>> getDescriptionRecord(var brandId, var formatId, var variantId, var descriptionId) async {
    var dbClient = await db;
    final res = await dbClient!.rawQuery("SELECT * FROM product where brand_id='$brandId' and format_id='$formatId' and variant_id='$variantId' and product_id='$descriptionId'");
    List<GetDescriptionData> list =
    res.isNotEmpty ? res.map((c) => GetDescriptionData.fromJson(c)).toList() : [];
    return list;
  }


  Future<AdminUsersModel> insertAdminUser(AdminUsersModel adminUserModel) async{
    var dbClient = await db;
    await dbClient!.insert('admin_users', adminUserModel.toMap());
    return adminUserModel;
  }

  Future<List<AdminUsersModel>> getAdminUsersList() async{
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient!.query("admin_users");
    return queryResult.map((e) => AdminUsersModel.fromMap(e)).toList();
  }

  Future<int> deleteAdminUser(int adminUserId) async{
    var dbClient = await db;
    return await dbClient!.delete(
        'admin_users',
        where: 'admin_user_id=?',
        whereArgs: [adminUserId]
    );
  }

  Future<int> updateAdminUser(AdminUsersModel adminUserModel) async{
    var dbClient = await db;
    return await dbClient!.update(
        'admin_users',
        adminUserModel.toMap(),
        where: 'admin_user_id=?',
        whereArgs: [adminUserModel.adminUserId]
    );
  }

  // Future<AdminUsersModel> getAdminUser(AdminUsersModel adminUserModel) async{
  //   var dbClient = await db;
  //   var sql = "Select * from admin_users where email=${adminUserModel.email}";
  //   final List<Map<String, Object?>> queryResult = dbClient!.rawQuery(sql) as List<Map<String, Object?>>;
  //   return queryResult.map((e) => AdminUsersModel.fromMap(e)).toList();
  // }

  Future<dynamic> getAdminUser(String email) async {
    var dbClient = await db;
    return await dbClient!.query(
        "admin_users",
        where: "email = ?",
        whereArgs: [email],
        limit: 1
    );
  }


  Future<String> getLastSyncDate() async {
    var dbClient = await db;
    final res = await dbClient!.rawQuery("SELECT * FROM sync_date");
    //print(res.length);
    if(res.length == 0){
      var dbHelper = DBHelper();
      dbHelper.insertSyncdate(SyncDate(syncId: 1, syncCode: 'lastsyncdate', syncDate: null));
     print('last sync date was not found in db');
    }
    String lastSyncDate = "";
    // raw query
    //List<Map> result = await dbClient.rawQuery('SELECT * FROM my_table WHERE name=?', ['Mary']);
    // List<Map> result = await dbClient.rawQuery("SELECT * FROM sync_date");
    //
    // // print the results
    res.forEach((row) => lastSyncDate = row['sync_date'].toString());
    // {_id: 2, name: Mary, age: 32}
    return lastSyncDate;
  }

  Future<int> updateSyncDate(SyncDate syncDate) async{
    var dbClient = await db;
    return await dbClient!.update(
        'sync_date',
        syncDate.toMap(),
        where: 'sync_id=?',
        whereArgs: [syncDate.syncId]
    );
  }


  Future<void> fetchAllData(lastSyncDate) async {
    if(lastSyncDate == ''){
      lastSyncDate = 'null';
    }
    String url = "${constants.apiBaseURL}/alldata/${lastSyncDate}";
    final response = await http.get(Uri.parse(url));
    var dbHelper = DBHelper();
    var dba = AuditentriesDBHelper();
    List<dynamic> response_data = jsonDecode(response.body);
    for(var data in response_data){
      if(data['adminusers'] != null) {
        for (var users in data['adminusers']) {
          dbHelper.insertAdminUser(AdminUsersModel.fromMap(users));
        }
      }
      if(data['brand'] != null) {
        for (var brand in data['brand']) {
          dbHelper.insertBrand(BrandModel.fromMap(brand));
        }
      }
      if(data['format'] != null){
        for(var format in data['format']){
          dbHelper!.insertFormat(FormatModel.fromMap(format));
        }
      }
      if(data['company'] != null){
        for(var company in data['company']){
          dbHelper!.insertCompany(CompanyModel.fromMap(company));
        }
      }

      if(data['variant'] != null){
        for(var variant in data['variant']){
          dbHelper!.insertVariant(VariantModel.fromMap(variant));
        }
      }

      if(data['warehouse'] != null){
        for(var warehouse in data['warehouse']){
          dbHelper!.insertWarehouse(WarehouseModel.fromMap(warehouse));
        }
      }

      if(data['product'] != null){
        for(var description in data['product']){
          dbHelper!.insertProduct(ProductModel.fromMap(description));
        }
      }

      if(data['audit'] != null){
        for(var audit in data['audit']){
          dbHelper!.insert(AuditModel.fromMap(audit));
        }
      }

      if(data['auditentries'] != null){
        for(var auditentries in data['auditentries']){
          dba!.insert(AuditEntriesModel.fromMap(auditentries));
        }
      }

      // update last sync date
      String datetime = DateTime.now().toString();
      print(datetime);
      dbHelper.updateSyncDate(SyncDate(syncId: 1, syncCode: "lastsyncdate", syncDate: datetime));
    }
  }

  Future<void> syncDatabase() async {
    var dbHelper = DBHelper();
    String lastSyncDate = "";
    var syncDate = dbHelper!.getLastSyncDate();
    syncDate.then((value) => {
      lastSyncDate = value,
      dbHelper!.fetchAllData(lastSyncDate)
    });
  }

  Future<void> clearLocalDatabase() async{
    var dbClient = await db;
    var dbHelper = DBHelper();
    await dbClient!.rawQuery("Delete from audit");
    await dbClient!.rawQuery("Delete from audit_wise_entries");
    await dbClient!.rawQuery("Delete from brand");
    await dbClient!.rawQuery("Delete from format");
    await dbClient!.rawQuery("Delete from variant");
    await dbClient!.rawQuery("Delete from product");
    await dbClient!.rawQuery("Delete from warehouse");
    await dbClient!.rawQuery("Delete from company");
    await dbClient!.rawQuery("Delete from admin_users");
    dbHelper.updateSyncDate(SyncDate(syncId: 1, syncCode: "lastsyncdate", syncDate: ""));

  }

}