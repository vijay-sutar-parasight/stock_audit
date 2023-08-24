class AuditModel{
  final int? auditId;
  final String? title;
  final String? description;
  final String? status;

AuditModel({this.auditId, required this.title, required this.description, this.status});

AuditModel.fromMap(Map<String, dynamic> res):
auditId = res['audit_id'],
title = res['title'],
description = res['description'],
status = res['status'];

Map<String, Object?> toMap(){
  return{
    'audit_id' : auditId,
    'title' : title,
    'description' : description,
    'status' : status,
  };
}
}