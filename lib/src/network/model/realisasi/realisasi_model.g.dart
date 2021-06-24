// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realisasi_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RealisasiModel _$RealisasiModelFromJson(Map<String, dynamic> json) {
  return RealisasiModel(
    idRealisasi: GlobalFunction.fromJsonStringToInteger(json['id_realisasi']),
    idRencana: GlobalFunction.fromJsonStringToInteger(json['id_rencana']),
    tanggal: json['tanggal'] == null
        ? null
        : DateTime.parse(json['tanggal'] as String),
    mulai: json['mulai'] as String?,
    selesai: json['selesai'] as String?,
    status: json['status'] as String?,
    fotoMulai: json['foto_mulai'] as String?,
    fotoSelesai: json['foto_selesai'] as String?,
    fotoAktifitas1: json['foto_aktifitas1'] as String?,
    fotoAktifitas2: json['foto_aktifitas2'] as String?,
    fotoAktifitas3: json['foto_aktifitas3'] as String?,
    fotoAktifitas4: json['foto_aktifitas4'] as String?,
    totalPenjualan:
        GlobalFunction.fromJsonStringToInteger(json['total_penjualan']),
    pic: json['pic'] as String?,
    catatan: json['catatan'] as String?,
    createdBy: GlobalFunction.fromJsonStringToInteger(json['created_by']),
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updatedBy: GlobalFunction.fromJsonStringToInteger(json['updated_by']),
    updatedAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
  );
}

Map<String, dynamic> _$RealisasiModelToJson(RealisasiModel instance) =>
    <String, dynamic>{
      'id_realisasi':
          GlobalFunction.toJsonStringFromInteger(instance.idRealisasi),
      'id_rencana': GlobalFunction.toJsonStringFromInteger(instance.idRencana),
      'tanggal': instance.tanggal?.toIso8601String(),
      'mulai': instance.mulai,
      'selesai': instance.selesai,
      'status': instance.status,
      'foto_mulai': instance.fotoMulai,
      'foto_selesai': instance.fotoSelesai,
      'foto_aktifitas1': instance.fotoAktifitas1,
      'foto_aktifitas2': instance.fotoAktifitas2,
      'foto_aktifitas3': instance.fotoAktifitas3,
      'foto_aktifitas4': instance.fotoAktifitas4,
      'total_penjualan':
          GlobalFunction.toJsonStringFromInteger(instance.totalPenjualan),
      'pic': instance.pic,
      'catatan': instance.catatan,
      'created_by': GlobalFunction.toJsonStringFromInteger(instance.createdBy),
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_by': GlobalFunction.toJsonStringFromInteger(instance.updatedBy),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
