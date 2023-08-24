class WarehouseModel{
  final int? warehouseId;
  final String? warehouseName;
  final String? companyId;

  WarehouseModel({this.warehouseId, required this.warehouseName, required this.companyId});

  WarehouseModel.fromMap(Map<String, dynamic> res):
        warehouseId = res['warehouse_id'],
        warehouseName = res['warehouse_name'],
        companyId = res['company_id'];

Map<String, Object?> toMap(){
  return{
    'warehouse_id' : warehouseId,
    'warehouse_name' : warehouseName,
    'company_id' : companyId,
  };
}
}