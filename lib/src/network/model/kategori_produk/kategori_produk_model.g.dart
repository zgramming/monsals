// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kategori_produk_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KategoriProdukModel _$KategoriProdukModelFromJson(Map<String, dynamic> json) {
  return KategoriProdukModel(
    idKategoriP: GlobalFunction.fromJsonStringToInteger(json['id_kategoriP']),
    nama: json['nama'] as String?,
    kodeKategoriP: json['kode_kategoriP'] as String?,
    status: json['status'] as String?,
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

Map<String, dynamic> _$KategoriProdukModelToJson(
        KategoriProdukModel instance) =>
    <String, dynamic>{
      'id_kategoriP':
          GlobalFunction.toJsonStringFromInteger(instance.idKategoriP),
      'nama': instance.nama,
      'kode_kategoriP': instance.kodeKategoriP,
      'status': instance.status,
      'created_by': GlobalFunction.toJsonStringFromInteger(instance.createdBy),
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_by': GlobalFunction.toJsonStringFromInteger(instance.updatedBy),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
