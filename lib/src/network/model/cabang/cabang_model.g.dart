// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cabang_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CabangModel _$CabangModelFromJson(Map<String, dynamic> json) {
  return CabangModel(
    idCabang: GlobalFunction.fromJsonStringToInteger(json['id_cabang']),
    nama: json['nama'] as String?,
    kodeCabang: json['kode_cabang'] as String?,
    phone: json['phone'] as String?,
    fax: json['fax'] as String?,
    email: json['email'] as String?,
    alamat: json['alamat'] as String?,
    status: json['status'] as String?,
  );
}

Map<String, dynamic> _$CabangModelToJson(CabangModel instance) =>
    <String, dynamic>{
      'id_cabang': GlobalFunction.toJsonStringFromInteger(instance.idCabang),
      'nama': instance.nama,
      'kode_cabang': instance.kodeCabang,
      'phone': instance.phone,
      'fax': instance.fax,
      'email': instance.email,
      'alamat': instance.alamat,
      'status': instance.status,
    };
