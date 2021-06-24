// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'penjualan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PenjualanModel _$PenjualanModelFromJson(Map<String, dynamic> json) {
  return PenjualanModel(
    idPenjualan: GlobalFunction.fromJsonStringToInteger(json['id_penjualan']),
    jml: GlobalFunction.fromJsonStringToInteger(json['jml']),
    total: GlobalFunction.fromJsonStringToInteger(json['total']),
    createdBy: GlobalFunction.fromJsonStringToInteger(json['created_by']),
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updatedBy: GlobalFunction.fromJsonStringToInteger(json['updated_by']),
    updatedAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
    rencana: RencanaModel.fromJson(json['rencana'] as Map<String, dynamic>),
    produk: ProdukModel.fromJson(json['produk'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PenjualanModelToJson(PenjualanModel instance) =>
    <String, dynamic>{
      'id_penjualan':
          GlobalFunction.toJsonStringFromInteger(instance.idPenjualan),
      'jml': GlobalFunction.toJsonStringFromInteger(instance.jml),
      'total': GlobalFunction.toJsonStringFromInteger(instance.total),
      'created_by': GlobalFunction.toJsonStringFromInteger(instance.createdBy),
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_by': GlobalFunction.toJsonStringFromInteger(instance.updatedBy),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'rencana': instance.rencana,
      'produk': instance.produk,
    };
