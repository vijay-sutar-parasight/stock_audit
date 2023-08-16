class GetBrandData {
  int? brandId;
  String? brandName;
  String? companyId;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  GetBrandData(
      {this.brandId,
        this.brandName,
        this.companyId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  GetBrandData.fromJson(Map<String, dynamic> json) {
    brandId = json['brand_id'];
    brandName = json['brand_name'];
    companyId = json['company_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_id'] = this.brandId;
    data['brand_name'] = this.brandName;
    data['company_id'] = this.companyId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}