class CompanyModel{
  final int? companyId;
  final String? companyName;
  final String? companyAddress;
  final String? cmMobile;
  final String? city;

  CompanyModel({this.companyId, required this.companyName, required this.companyAddress, this.cmMobile, this.city});

  CompanyModel.fromMap(Map<String, dynamic> res):
        companyId = res['company_id'],
        companyName = res['company_name'],
        companyAddress = res['company_address'],
        cmMobile = res['cm_mobile'],
        city = res['city'];



Map<String, Object?> toMap(){
  return{
    'company_id' : companyId,
    'company_name' : companyName,
    'company_address' : companyAddress,
    'cm_mobile' : cmMobile,
    'city' : city,


  };
}
}