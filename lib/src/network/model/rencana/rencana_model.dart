import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rencana_model.g.dart';

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class RencanaModel extends Equatable {
  const RencanaModel({
    this.idRencana,
    this.kegiatan = '',
    this.tanggal,
    this.kode = '',
    this.kategori = '',
    this.customerNama = '',
    this.customerAlamat = '',
    this.customerPhone = '',
  });

  @JsonKey(
    toJson: GlobalFunction.toJsonStringFromInteger,
    fromJson: GlobalFunction.fromJsonStringToInteger,
  )
  final int? idRencana;
  final String kegiatan;
  final DateTime? tanggal;
  final String kode;
  final String kategori;
  final String customerNama;
  final String customerAlamat;
  final String customerPhone;

  factory RencanaModel.fromJson(Map<String, dynamic> json) => _$RencanaModelFromJson(json);
  Map<String, dynamic> toJson() => _$RencanaModelToJson(this);

  @override
  List get props {
    return [
      idRencana,
      kegiatan,
      tanggal,
      kode,
      kategori,
      customerNama,
      customerAlamat,
      customerPhone,
    ];
  }

  @override
  bool get stringify => true;

  RencanaModel copyWith({
    int? idRencana,
    String? kegiatan,
    DateTime? tanggal,
    String? kode,
    String? kategori,
    String? customerNama,
    String? customerAlamat,
    String? customerPhone,
  }) {
    return RencanaModel(
      idRencana: idRencana ?? this.idRencana,
      kegiatan: kegiatan ?? this.kegiatan,
      tanggal: tanggal ?? this.tanggal,
      kode: kode ?? this.kode,
      kategori: kategori ?? this.kategori,
      customerNama: customerNama ?? this.customerNama,
      customerAlamat: customerAlamat ?? this.customerAlamat,
      customerPhone: customerPhone ?? this.customerPhone,
    );
  }
}
