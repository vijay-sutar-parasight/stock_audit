class GetDescriptionData {
  int? productId;
  String? productName;
  String? itemNumber;
  String? companyId;
  String? formatId;
  String? variantId;
  String? brandId;
  String? warehouseId;
  String? systemUnit;
  String? valuationPerUnit;
  String? weight;
  String? mrp;
  String? combiType;
  String? pcsCases;
  String? totalStockValue;
  String? mfgDate;
  String? mfgMonth;
  String? mfgYear;
  String? expDate;
  String? expMonth;
  String? expYear;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  GetDescriptionData(
      {this.productId,
        this.productName,
        this.itemNumber,
        this.companyId,
        this.formatId,
        this.variantId,
        this.brandId,
        this.warehouseId,
        this.systemUnit,
        this.valuationPerUnit,
        this.weight,
        this.mrp,
        this.combiType,
        this.pcsCases,
        this.totalStockValue,
        this.mfgDate,
        this.mfgMonth,
        this.mfgYear,
        this.expDate,
        this.expMonth,
        this.expYear,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  GetDescriptionData.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    itemNumber = json['item_number'];
    companyId = json['company_id'];
    formatId = json['format_id'];
    variantId = json['variant_id'];
    brandId = json['brand_id'];
    warehouseId = json['warehouse_id'];
    systemUnit = json['system_unit'];
    valuationPerUnit = json['valuation_per_unit'];
    weight = json['weight'];
    mrp = json['mrp'];
    combiType = json['combi_type'];
    pcsCases = json['pcs_cases'];
    totalStockValue = json['total_stock_value'];
    mfgDate = json['mfg_date'];
    mfgMonth = json['mfg_month'];
    mfgYear = json['mfg_year'];
    expDate = json['exp_date'];
    expMonth = json['exp_month'];
    expYear = json['exp_year'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['item_number'] = this.itemNumber;
    data['company_id'] = this.companyId;
    data['format_id'] = this.formatId;
    data['variant_id'] = this.variantId;
    data['brand_id'] = this.brandId;
    data['warehouse_id'] = this.warehouseId;
    data['system_unit'] = this.systemUnit;
    data['valuation_per_unit'] = this.valuationPerUnit;
    data['weight'] = this.weight;
    data['mrp'] = this.mrp;
    data['combi_type'] = this.combiType;
    data['pcs_cases'] = this.pcsCases;
    data['total_stock_value'] = this.totalStockValue;
    data['mfg_date'] = this.mfgDate;
    data['mfg_month'] = this.mfgMonth;
    data['mfg_year'] = this.mfgYear;
    data['exp_date'] = this.expDate;
    data['exp_month'] = this.expMonth;
    data['exp_year'] = this.expYear;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
