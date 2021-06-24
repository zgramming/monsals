// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kegiatan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KegiatanModel _$KegiatanModelFromJson(Map<String, dynamic> json) {
  return KegiatanModel(
    idRencana: GlobalFunction.fromJsonStringToInteger(json['id_rencana']),
    kegiatan: json['kegiatan'] as String,
    tanggal: json['tanggal'] == null
        ? null
        : DateTime.parse(json['tanggal'] as String),
    mulai: json['mulai'] as String,
    selesai: json['selesai'] as String,
    customer: json['customer'] as String,
    statusRealisasi: json['status_realisasi'] as String,
  );
}

Map<String, dynamic> _$KegiatanModelToJson(KegiatanModel instance) =>
    <String, dynamic>{
      'id_rencana': GlobalFunction.toJsonStringFromInteger(instance.idRencana),
      'kegiatan': instance.kegiatan,
      'tanggal': instance.tanggal?.toIso8601String(),
      'mulai': instance.mulai,
      'selesai': instance.selesai,
      'customer': instance.customer,
      'status_realisasi': instance.statusRealisasi,
    };
