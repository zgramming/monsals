import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';
import 'package:json_annotation/json_annotation.dart';

part 'realisasi_model.g.dart';

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class RealisasiModel extends Equatable {
  const RealisasiModel({
    this.idRealisasi,
    this.idRencana,
    this.tanggal,
    this.mulai,
    this.selesai,
    this.status,
    this.fotoMulai,
    this.fotoSelesai,
    this.fotoAktifitas1,
    this.fotoAktifitas2,
    this.fotoAktifitas3,
    this.fotoAktifitas4,
    this.totalPenjualan,
    this.pic,
    this.catatan,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  @JsonKey(
    toJson: GlobalFunction.toJsonStringFromInteger,
    fromJson: GlobalFunction.fromJsonStringToInteger,
  )
  final int? idRealisasi;
  @JsonKey(
    toJson: GlobalFunction.toJsonStringFromInteger,
    fromJson: GlobalFunction.fromJsonStringToInteger,
  )
  final int? idRencana;
  final DateTime? tanggal;
  final String? mulai;
  final String? selesai;
  final String? status;
  final String? fotoMulai;
  final String? fotoSelesai;
  final String? fotoAktifitas1;
  final String? fotoAktifitas2;
  final String? fotoAktifitas3;
  final String? fotoAktifitas4;
  @JsonKey(
    toJson: GlobalFunction.toJsonStringFromInteger,
    fromJson: GlobalFunction.fromJsonStringToInteger,
  )
  final int? totalPenjualan;
  final String? pic;
  final String? catatan;
  @JsonKey(
    toJson: GlobalFunction.toJsonStringFromInteger,
    fromJson: GlobalFunction.fromJsonStringToInteger,
  )
  final int? createdBy;
  final DateTime? createdAt;
  @JsonKey(
    toJson: GlobalFunction.toJsonStringFromInteger,
    fromJson: GlobalFunction.fromJsonStringToInteger,
  )
  final int? updatedBy;
  final DateTime? updatedAt;

  factory RealisasiModel.fromJson(Map<String, dynamic> json) => _$RealisasiModelFromJson(json);
  Map<String, dynamic> toJson() => _$RealisasiModelToJson(this);

  @override
  List get props {
    return [
      idRealisasi,
      idRencana,
      tanggal,
      mulai,
      selesai,
      status,
      fotoMulai,
      fotoSelesai,
      fotoAktifitas1,
      fotoAktifitas2,
      fotoAktifitas3,
      fotoAktifitas4,
      totalPenjualan,
      pic,
      catatan,
      createdBy,
      createdAt,
      updatedBy,
      updatedAt,
    ];
  }

  @override
  bool get stringify => true;

  RealisasiModel copyWith({
    int? idRealisasi,
    int? idRencana,
    DateTime? tanggal,
    String? mulai,
    String? selesai,
    String? status,
    String? fotoMulai,
    String? fotoSelesai,
    String? fotoAktifitas1,
    String? fotoAktifitas2,
    String? fotoAktifitas3,
    String? fotoAktifitas4,
    int? totalPenjualan,
    String? pic,
    String? catatan,
    int? createdBy,
    DateTime? createdAt,
    int? updatedBy,
    DateTime? updatedAt,
  }) {
    return RealisasiModel(
      idRealisasi: idRealisasi ?? this.idRealisasi,
      idRencana: idRencana ?? this.idRencana,
      tanggal: tanggal ?? this.tanggal,
      mulai: mulai ?? this.mulai,
      selesai: selesai ?? this.selesai,
      status: status ?? this.status,
      fotoMulai: fotoMulai ?? this.fotoMulai,
      fotoSelesai: fotoSelesai ?? this.fotoSelesai,
      fotoAktifitas1: fotoAktifitas1 ?? this.fotoAktifitas1,
      fotoAktifitas2: fotoAktifitas2 ?? this.fotoAktifitas2,
      fotoAktifitas3: fotoAktifitas3 ?? this.fotoAktifitas3,
      fotoAktifitas4: fotoAktifitas4 ?? this.fotoAktifitas4,
      totalPenjualan: totalPenjualan ?? this.totalPenjualan,
      pic: pic ?? this.pic,
      catatan: catatan ?? this.catatan,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedBy: updatedBy ?? this.updatedBy,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

// @JsonKey(
//     toJson: GlobalFunction.toJsonStringFromInteger,
//     fromJson: GlobalFunction.fromJsonStringToInteger,
//   )

// factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
// Map<String, dynamic> toJson() => _$UserModelToJson(this);