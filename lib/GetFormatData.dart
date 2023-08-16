class GetFormatData {
  int? formatId;
  String? formatName;
  String? brandId;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  GetFormatData(
      {this.formatId,
        this.formatName,
        this.brandId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  GetFormatData.fromJson(Map<String, dynamic> json) {
    formatId = json['format_id'];
    formatName = json['format_name'];
    brandId = json['brand_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['format_id'] = this.formatId;
    data['format_name'] = this.formatName;
    data['brand_id'] = this.brandId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}