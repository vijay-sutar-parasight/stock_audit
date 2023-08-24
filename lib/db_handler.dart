import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stock_audit/audit.dart';
import 'package:stock_audit/models/auditmodel.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import 'package:stock_audit/util/constants.dart' as constants;
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
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate (Database db, int version) async{
    await db.execute("CREATE TABLE IF NOT EXISTS audit (audit_id INTEGER PRIMARY KEY AUTOINCREMENT, company_id TEXT NULL, audit_description TEXT NULL, audit_status TEXT NULL)");
    await db.execute("CREATE TABLE IF NOT EXISTS audit_wise_entries (entry_id INTEGER PRIMARY KEY AUTOINCREMENT, audit_id TEXT NULL, company_id TEXT NULL, product_id TEXT NULL, brand_id TEXT NULL, format_id TEXT NULL, variant_id TEXT NULL, warehouse_id TEXT NULL, user_id TEXT NULL, admin_user_name TEXT NULL, mfg_month TEXT NULL, mfg_year TEXT NULL, exp_month TEXT NULL, exp_year TEXT NULL, actual_unit TEXT NULL, system_unit TEXT NULL, weight TEXT NULL, mrp TEXT NULL,  valuation_per_unit TEXT NULL, total_amount TEXT NULL, factor_1 TEXT NULL,  oprator TEXT NULL, factor_2 TEXT NULL, calculation_arr TEXT NULL, city TEXT NULL, product_name TEXT NULL, company_name TEXT NULL, brand_name TEXT NULL, format_name TEXT NULL, variant_name TEXT NULL, warehouse_name TEXT NULL, combi_type TEXT NULL, pcs_cases TEXT NULL, total_stock_value TEXT NULL, mfg_date TEXT NULL, exp_date TEXT NULL, created_at TEXT NULL, updated_at TEXT NULL, deleted_at TEXT NULL)");
    await db.execute("CREATE TABLE IF NOT EXISTS brand_id (brand_id INTEGER PRIMARY KEY AUTOINCREMENT, brand_name TEXT NULL, company_id TEXT NULL)");
    await db.execute("CREATE TABLE IF NOT EXISTS company (company_id INTEGER PRIMARY KEY AUTOINCREMENT, company_name TEXT NULL, company_address TEXT NULL, cm_mobile TEXT NULL, city TEXT NULL)");
    await db.execute("CREATE TABLE IF NOT EXISTS format (format_id INTEGER PRIMARY KEY AUTOINCREMENT, format_name TEXT NULL, brand_id TEXT NULL)");
    await db.execute("CREATE TABLE IF NOT EXISTS product (product_id INTEGER PRIMARY KEY AUTOINCREMENT, product_name TEXT NULL, item_number TEXT NULL, company_id TEXT NULL, format_id TEXT NULL, variant_id TEXT NULL, brand_id TEXT NULL, warehouse_id TEXT NULL, system_unit TEXT NULL, valuation_per_unit TEXT NULL, weight TEXT NULL, mrp TEXT NULL, combi_type TEXT NULL, pcs_cases TEXT NULL, total_stock_value TEXT NULL, mfg_date TEXT NULL, mfg_month TEXT NULL, mfg_year TEXT NULL, exp_date TEXT NULL, exp_month TEXT NULL, exp_year TEXT NULL)");
    await db.execute("CREATE TABLE IF NOT EXISTS variant (variant_id INTEGER PRIMARY KEY AUTOINCREMENT, brand_id TEXT NULL, variant_name TEXT NULL, format_id TEXT NULL)");
    await db.execute("CREATE TABLE IF NOT EXISTS warehouse (warehouse_id INTEGER PRIMARY KEY AUTOINCREMENT, warehouse_name TEXT NULL, company_id TEXT NULL)");

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

}