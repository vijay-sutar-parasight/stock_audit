class AuditModel{
  final int? id;
  final String? title;
  final String? description;

AuditModel({this.id, required this.title, required this.description});

AuditModel.fromMap(Map<String, dynamic> res):
id = res['id'],
title = res['title'],
description = res['description'];

Map<String, Object?> toMap(){
  return{
    'id' : id,
    'title' : title,
    'description' : description,
  };
}
}