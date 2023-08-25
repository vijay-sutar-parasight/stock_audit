class VariantModel{
  final int? variantId;
  final String? brandId;
  final String? formatId;
  final String? variantName;

  VariantModel({this.variantId, required this.brandId, required this.formatId, this.variantName});

  VariantModel.fromMap(Map<String, dynamic> res):
        variantId = res['variant_id'],
        brandId = res['brand_id'],
        formatId = res['format_id'],
        variantName = res['variant_name'];

Map<String, Object?> toMap(){
  return{
    'variant_id' : variantId,
    'brand_id' : brandId,
    'format_id' : formatId,
    'variant_name' : variantName,
  };
}
}