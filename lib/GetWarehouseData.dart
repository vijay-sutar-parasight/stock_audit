class GetWarehouseData {
  int? warehouseId;
  String? warehouseName;
  String? companyId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  GetWarehouseData(
      {this.warehouseId,
        this.warehouseName,
        this.companyId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  GetWarehouseData.fromJson(Map<String, dynamic> json) {
    warehouseId = json['warehouse_id'];
    warehouseName = json['warehouse_name'];
    companyId = json['company_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['warehouse_id'] = this.warehouseId;
    data['warehouse_name'] = this.warehouseName;
    data['company_id'] = this.companyId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
