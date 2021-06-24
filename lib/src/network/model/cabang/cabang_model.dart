import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cabang_model.g.dart';

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class CabangModel extends Equatable {
  const CabangModel({
    this.idCabang,
    this.nama = '',
    this.kodeCabang = '',
    this.phone = '',
    this.fax = '',
    this.email = '',
    this.alamat = '',
    this.status = '',
  });

  @JsonKey(
    toJson: GlobalFunction.toJsonStringFromInteger,
    fromJson: GlobalFunction.fromJsonStringToInteger,
  )
  final int? idCabang;
  final String? nama;
  final String? kodeCabang;
  final String? phone;
  final String? fax;
  final String? email;
  final String? alamat;
  final String? status;

  factory CabangModel.fromJson(Map<String, dynamic> json) => _$CabangModelFromJson(json);
  Map<String, dynamic> toJson() => _$CabangModelToJson(this);

  @override
  List get props {
    return [
      idCabang,
      nama,
      kodeCabang,
      phone,
      fax,
      email,
      alamat,
      status,
    ];
  }

  @override
  bool get stringify => true;

  CabangModel copyWith({
    int? idCabang,
    String? nama,
    String? kodeCabang,
    String? phone,
    String? fax,
    String? email,
    String? alamat,
    String? status,
  }) {
    return CabangModel(
      idCabang: idCabang ?? this.idCabang,
      nama: nama ?? this.nama,
      kodeCabang: kodeCabang ?? this.kodeCabang,
      phone: phone ?? this.phone,
      fax: fax ?? this.fax,
      email: email ?? this.email,
      alamat: alamat ?? this.alamat,
      status: status ?? this.status,
    );
  }
}
