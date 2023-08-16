class GetAuditData {
  int? auditId;
  String? auditDiscription;
  String? companyId;
  String? auditStatus;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  GetAuditData(
      {this.auditId,
        this.auditDiscription,
        this.companyId,
        this.auditStatus,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  GetAuditData.fromJson(Map<String, dynamic> json) {
    auditId = json['audit_id'];
    auditDiscription = json['audit_discription'];
    companyId = json['company_id'];
    auditStatus = json['audit_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['audit_id'] = this.auditId;
    data['audit_discription'] = this.auditDiscription;
    data['company_id'] = this.companyId;
    data['audit_status'] = this.auditStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
