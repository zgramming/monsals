// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesModel _$SalesModelFromJson(Map<String, dynamic> json) {
  return SalesModel(
    idSales: GlobalFunction.fromJsonStringToInteger(json['id_sales']),
    nama: json['nama'] as String?,
    kodeSales: json['kode_sales'] as String?,
    hp: json['hp'] as String?,
    email: json['email'] as String?,
    alamat: json['alamat'] as String?,
    status: json['status'] as String?,
    foto: json['foto'] as String?,
    cabang: CabangModel.fromJson(json['cabang'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SalesModelToJson(SalesModel instance) =>
    <String, dynamic>{
      'id_sales': GlobalFunction.toJsonStringFromInteger(instance.idSales),
      'nama': instance.nama,
      'kode_sales': instance.kodeSales,
      'hp': instance.hp,
      'email': instance.email,
      'alamat': instance.alamat,
      'status': instance.status,
      'foto': instance.foto,
      'cabang': instance.cabang,
    };
