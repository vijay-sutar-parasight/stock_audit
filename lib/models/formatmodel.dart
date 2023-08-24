class FormatModel{
  final int? formatId;
  final String? brandId;
  final String? formatName;

  FormatModel({this.formatId, required this.brandId, required this.formatName});

  FormatModel.fromMap(Map<String, dynamic> res):
        formatId = res['format_id'],
        brandId = res['brand_id'],
        formatName = res['format_name'];

Map<String, Object?> toMap(){
  return{
    'format_id' : formatId,
    'brand_id' : brandId,
    'format_name' : formatName,
  };
}
}