class AuditModel{
  final int? auditId;
  final String? companyId;
  final String? auditDescription;
  final String? auditStatus;

AuditModel({this.auditId, required this.companyId, required this.auditDescription, this.auditStatus});

AuditModel.fromMap(Map<String, dynamic> res):
      auditId = res['audit_id'],
      companyId = res['company_id'],
      auditDescription = res['audit_description'],
      auditStatus = res['audit_status'];

Map<String, Object?> toMap(){
  return{
    'audit_id' : auditId,
    'company_id' : companyId,
    'audit_description' : auditDescription,
    'audit_status' : auditStatus,
  };
}
}