// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'produk_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProdukModel _$ProdukModelFromJson(Map<String, dynamic> json) {
  return ProdukModel(
    idProduk: GlobalFunction.fromJsonStringToInteger(json['id_produk']),
    kode: json['kode'] as String,
    nama: json['nama'] as String,
    exp: json['exp'] as String,
    deskripsi: json['deskripsi'] as String,
    harga: GlobalFunction.fromJsonStringToInteger(json['harga']),
    stok: GlobalFunction.fromJsonStringToInteger(json['stok']),
    foto: json['foto'] as String?,
  );
}

Map<String, dynamic> _$ProdukModelToJson(ProdukModel instance) =>
    <String, dynamic>{
      'id_produk': GlobalFunction.toJsonStringFromInteger(instance.idProduk),
      'kode': instance.kode,
      'nama': instance.nama,
      'exp': instance.exp,
      'deskripsi': instance.deskripsi,
      'harga': GlobalFunction.toJsonStringFromInteger(instance.harga),
      'stok': GlobalFunction.toJsonStringFromInteger(instance.stok),
      'foto': instance.foto,
    };
