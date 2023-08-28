class GetCompanyData {
  int? companyId;
  String? companyName;
  String? companyAddress;
  String? cmMobile;
  String? city;

  GetCompanyData(
      {this.companyId,
        this.companyName,
        this.companyAddress,
        this.cmMobile,
        this.city,});

  GetCompanyData.fromJson(Map<String, dynamic> json) {
    companyId = json['company_id'];
    companyName = json['company_name'];
    companyAddress = json['company_address'];
    cmMobile = json['cm_mobile'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company_id'] = this.companyId;
    data['company_name'] = this.companyName;
    data['company_address'] = this.companyAddress;
    data['cm_mobile'] = this.cmMobile;
    data['city'] = this.city;
    return data;
  }
}
