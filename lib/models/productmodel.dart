class ProductModel{
  final int? productId;
  final String? productName;
  final String? itemNumber;
  final String? companyId;
  final String? formatId;
  final String? variantId;
  final String? brandId;
  final String? warehouseId;
  final String? systemUnit;
  final String? valuationPerUnit;
  final String? weight;
  final String? mrp;
  final String? combiType;
  final String? pcsCases;
  final String? totalStockValue;
  final String? mfgDate;
  final String? mfgMonth;
  final String? mfgYear;
  final String? expDate;
  final String? expMonth;
  final String? expYear;

  ProductModel({this.productId, required this.productName, required this.companyId, this.formatId, this.variantId, this.brandId, this.warehouseId, this.systemUnit, this.valuationPerUnit, this.weight, this.mrp, this.combiType, this.pcsCases, this.totalStockValue, this.mfgDate, this.mfgMonth, this.mfgYear, this.expDate, this.expMonth, this.expYear, this.itemNumber});

  ProductModel.fromMap(Map<String, dynamic> res):
        productId = res['product_id'],
        productName = res['product_name'],
        companyId = res['company_id'],
        formatId = res['format_id'],
        brandId = res['brand_id'],
        variantId = res['variant_id'],
        warehouseId = res['warehouse_id'],
        itemNumber = res['item_number'],
        systemUnit = res['system_unit'],
        valuationPerUnit = res['valuation_per_unit'],
        weight = res['weight'],
        mrp = res['mrp'],
        combiType = res['combi_type'],
        pcsCases = res['pcs_cases'],
        totalStockValue = res['total_stock_value'],
        mfgDate = res['mfg_date'],
        mfgMonth = res['mfg_month'],
        mfgYear = res['mfg_year'],
        expDate = res['exp_date'],
        expMonth = res['exp_month'],
        expYear = res['exp_year'];


Map<String, Object?> toMap(){
  return{
    'product_id' : productName,
    'product_name' : productName,
    'company_id' : companyId,
    'format_id' : formatId,
    'brand_id' : brandId,
    'variant_id' : variantId,
    'warehouse_id' : warehouseId,
    'item_number' : itemNumber,
    'system_unit' : systemUnit,
    'valuation_per_unit' : valuationPerUnit,
    'weight' : weight,
    'mrp' : mrp,
    'combi_type' : combiType,
    'pcs_cases' : pcsCases,
    'total_stock_value' : totalStockValue,
    'mfg_date' : mfgDate,
    'mfg_month' : mfgMonth,
    'mfg_year' : mfgYear,
    'exp_date' : expDate,
    'exp_month' : expMonth,
    'exp_year' : expYear,
  };
}
}