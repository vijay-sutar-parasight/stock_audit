import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

import '../../models/auditentriesmodel.dart';
import 'package:stock_audit/util/constants.dart' as constants;
class AuditentriesDBHelper{
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
    var db = await openDatabase(path, version: 2, onCreate: _onCreate);
    return db;
  }

  _onCreate (Database db, int version) async{
    print("in create statement");
    await db.execute("CREATE TABLE IF NOT EXISTS audit_wise_entries (entry_id INTEGER PRIMARY KEY AUTOINCREMENT, audit_id TEXT NOT NULL, company_id TEXT NOT NULL, product_id TEXT NOT NULL, brand_id TEXT NOT NULL, format_id TEXT NOT NULL, variant_id TEXT NOT NULL, warehouse_id TEXT NOT NULL, user_id TEXT NOT NULL, admin_user_name TEXT NOT NULL, mfg_month TEXT NOT NULL, mfg_year TEXT NOT NULL, exp_month TEXT NOT NULL, exp_year TEXT NOT NULL, actual_unit TEXT NOT NULL, system_unit TEXT NOT NULL, weight TEXT NOT NULL, mrp TEXT NOT NULL,  valuation_per_unit TEXT NOT NULL, total_amount TEXT NOT NULL, factor_1 TEXT NOT NULL,  oprator TEXT NOT NULL, factor_2 TEXT NOT NULL, calculation_arr TEXT NOT NULL, city TEXT NOT NULL, product_name TEXT NOT NULL, company_name TEXT NOT NULL, brand_name TEXT NOT NULL, format_name TEXT NOT NULL, variant_name TEXT NOT NULL, warehouse_name TEXT NOT NULL, combi_type TEXT NOT NULL, pcs_cases TEXT NOT NULL, total_stock_value TEXT NOT NULL, mfg_date TEXT NOT NULL, exp_date TEXT NOT NULL, created_at TEXT NOT NULL, updated_at TEXT NOT NULL, deleted_at TEXT NOT NULL)");
  }

  Future<AuditEntriesModel> insert(AuditEntriesModel auditEntriesModel) async{
    var dbClient = await db;
    await dbClient!.insert('audit_wise_entries', auditEntriesModel.toMap());
    return auditEntriesModel;
  }

  Future<List<AuditEntriesModel>> getAuditEntriesList(companyId) async{
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient!.query("audit_wise_entries");
    return queryResult.map((e) => AuditEntriesModel.fromMap(e)).toList();
  }

  Future<int> delete(int entryId) async{
    var dbClient = await db;
    return await dbClient!.delete(
      'audit_wise_entries',
      where: 'entry_id=?',
      whereArgs: [entryId]
    );
  }

  Future<int> update(AuditEntriesModel auditEntriesModel) async{
    var dbClient = await db;
    return await dbClient!.update(
        'audit_wise_entries',
        auditEntriesModel.toMap(),
        where: 'entry_id=?',
        whereArgs: [auditEntriesModel.entryId]
    );
  }

}