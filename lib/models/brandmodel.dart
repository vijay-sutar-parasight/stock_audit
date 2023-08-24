class BrandModel{
  final int? brandId;
  final String? companyId;
  final String? brandName;

  BrandModel({this.brandId, required this.companyId, required this.brandName});

  BrandModel.fromMap(Map<String, dynamic> res):
        brandId = res['brand_id'],
        companyId = res['company_id'],
        brandName = res['brand_name'];

Map<String, Object?> toMap(){
  return{
    'brand_id' : brandId,
    'company_id' : companyId,
    'brand_name' : brandName,
  };
}
}