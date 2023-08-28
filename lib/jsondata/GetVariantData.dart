class GetVariantData {
  int? variantId;
  String? brandId;
  String? variantName;
  String? formatId;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  GetVariantData(
      {this.variantId,
        this.brandId,
        this.variantName,
        this.formatId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  GetVariantData.fromJson(Map<String, dynamic> json) {
    variantId = json['variant_id'];
    brandId = json['brand_id'];
    variantName = json['variant_name'];
    formatId = json['format_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['variant_id'] = this.variantId;
    data['brand_id'] = this.brandId;
    data['variant_name'] = this.variantName;
    data['format_id'] = this.formatId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}