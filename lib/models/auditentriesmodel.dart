class AuditEntriesModel {
  int? entryId;
  String? auditId;
  String? companyId;
  String? productId;
  String? brandId;
  String? formatId;
  String? variantId;
  String? warehouseId;
  String? userId;
  String? adminUserName;
  String? mfgMonth;
  String? mfgYear;
  String? expMonth;
  String? expYear;
  String? actualUnit;
  String? systemUnit;
  String? weight;
  String? mrp;
  String? valuationPerUnit;
  String? totalAmount;
  Null? factor1;
  Null? oprator;
  Null? factor2;
  String? calculationArr;
  Null? city;
  String? productName;
  String? companyName;
  String? brandName;
  String? formatName;
  String? variantName;
  String? warehouseName;
  String? combiType;
  String? pcsCases;
  String? totalStockValue;
  String? mfgDate;
  String? expDate;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  AuditEntriesModel(
      {this.entryId,
        this.auditId,
        this.companyId,
        this.productId,
        this.brandId,
        this.formatId,
        this.variantId,
        this.warehouseId,
        this.userId,
        this.adminUserName,
        this.mfgMonth,
        this.mfgYear,
        this.expMonth,
        this.expYear,
        this.actualUnit,
        this.systemUnit,
        this.weight,
        this.mrp,
        this.valuationPerUnit,
        this.totalAmount,
        this.factor1,
        this.oprator,
        this.factor2,
        this.calculationArr,
        this.city,
        this.productName,
        this.companyName,
        this.brandName,
        this.formatName,
        this.variantName,
        this.warehouseName,
        this.combiType,
        this.pcsCases,
        this.totalStockValue,
        this.mfgDate,
        this.expDate,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});


  AuditEntriesModel.fromMap(Map<String, dynamic> res) {
    entryId = res['entry_id'];
    auditId = res['audit_id'];
    companyId = res['company_id'];
    productId = res['product_id'];
    brandId = res['brand_id'];
    formatId = res['format_id'];
    variantId = res['variant_id'];
    warehouseId = res['warehouse_id'];
    userId = res['user_id'];
    adminUserName = res['admin_user_name'];
    mfgMonth = res['mfg_month'];
    mfgYear = res['mfg_year'];
    expMonth = res['exp_month'];
    expYear = res['exp_year'];
    actualUnit = res['actual_unit'];
    systemUnit = res['system_unit'];
    weight = res['weight'];
    mrp = res['mrp'];
    valuationPerUnit = res['valuation_per_unit'];
    totalAmount = res['total_amount'];
    factor1 = res['factor_1'];
    oprator = res['oprator'];
    factor2 = res['factor_2'];
    calculationArr = res['calculation_arr'];
    city = res['city'];
    productName = res['product_name'];
    companyName = res['company_name'];
    brandName = res['brand_name'];
    formatName = res['format_name'];
    variantName = res['variant_name'];
    warehouseName = res['warehouse_name'];
    combiType = res['combi_type'];
    pcsCases = res['pcs_cases'];
    totalStockValue = res['total_stock_value'];
    mfgDate = res['mfg_date'];
    expDate = res['exp_date'];
    createdAt = res['created_at'];
    updatedAt = res['updated_at'];
    deletedAt = res['deleted_at'];
  }

  Map<String, Object?> toMap(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['entry_id'] = entryId;
    data['audit_id'] = auditId;
    data['company_id'] = companyId;
    data['product_id'] = productId;
    data['brand_id'] = brandId;
    data['format_id'] = formatId;
    data['variant_id'] = variantId;
    data['warehouse_id'] = warehouseId;
    data['user_id'] = userId;
    data['admin_user_name'] = adminUserName;
    data['mfg_month'] = mfgMonth;
    data['mfg_year'] = mfgYear;
    data['exp_month'] = expMonth;
    data['exp_year'] = expYear;
    data['actual_unit'] = actualUnit;
    data['system_unit'] = systemUnit;
    data['weight'] = weight;
    data['mrp'] = mrp;
    data['valuation_per_unit'] = valuationPerUnit;
    data['total_amount'] = totalAmount;
    data['factor_1'] = factor1;
    data['oprator'] = oprator;
    data['factor_2'] = factor2;
    data['calculation_arr'] = calculationArr;
    data['city'] = city;
    data['product_name'] = productName;
    data['company_name'] = companyName;
    data['brand_name'] = brandName;
    data['format_name'] = formatName;
    data['variant_name'] = variantName;
    data['warehouse_name'] = warehouseName;
    data['combi_type'] = combiType;
    data['pcs_cases'] = pcsCases;
    data['total_stock_value'] = totalStockValue;
    data['mfg_date'] = mfgDate;
    data['exp_date'] = expDate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}