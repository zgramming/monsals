// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rencana_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RencanaModel _$RencanaModelFromJson(Map<String, dynamic> json) {
  return RencanaModel(
    idRencana: GlobalFunction.fromJsonStringToInteger(json['id_rencana']),
    kegiatan: json['kegiatan'] as String,
    tanggal: json['tanggal'] == null
        ? null
        : DateTime.parse(json['tanggal'] as String),
    kode: json['kode'] as String,
    kategori: json['kategori'] as String,
    customerNama: json['customer_nama'] as String,
    customerAlamat: json['customer_alamat'] as String,
    customerPhone: json['customer_phone'] as String,
  );
}

Map<String, dynamic> _$RencanaModelToJson(RencanaModel instance) =>
    <String, dynamic>{
      'id_rencana': GlobalFunction.toJsonStringFromInteger(instance.idRencana),
      'kegiatan': instance.kegiatan,
      'tanggal': instance.tanggal?.toIso8601String(),
      'kode': instance.kode,
      'kategori': instance.kategori,
      'customer_nama': instance.customerNama,
      'customer_alamat': instance.customerAlamat,
      'customer_phone': instance.customerPhone,
    };
