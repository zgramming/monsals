import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';
import 'package:json_annotation/json_annotation.dart';

part 'kegiatan_model.g.dart';

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class KegiatanModel extends Equatable {
  const KegiatanModel({
    this.idRencana,
    this.kegiatan = '',
    this.tanggal,
    this.mulai = '',
    this.selesai = '',
    this.customer = '',
    this.statusRealisasi = '',
  });

  @JsonKey(
    toJson: GlobalFunction.toJsonStringFromInteger,
    fromJson: GlobalFunction.fromJsonStringToInteger,
  )
  final int? idRencana;
  final String kegiatan;
  final DateTime? tanggal;
  final String mulai;
  final String selesai;
  final String customer;
  final String statusRealisasi;

  factory KegiatanModel.fromJson(Map<String, dynamic> json) => _$KegiatanModelFromJson(json);
  Map<String, dynamic> toJson() => _$KegiatanModelToJson(this);

  @override
  List get props {
    return [
      idRencana,
      kegiatan,
      tanggal,
      mulai,
      selesai,
      customer,
      statusRealisasi,
    ];
  }

  @override
  bool get stringify => true;

  KegiatanModel copyWith({
    int? idRencana,
    String? kegiatan,
    DateTime? tanggal,
    String? mulai,
    String? selesai,
    String? customer,
    String? statusRealisasi,
  }) {
    return KegiatanModel(
      idRencana: idRencana ?? this.idRencana,
      kegiatan: kegiatan ?? this.kegiatan,
      tanggal: tanggal ?? this.tanggal,
      mulai: mulai ?? this.mulai,
      selesai: selesai ?? this.selesai,
      customer: customer ?? this.customer,
      statusRealisasi: statusRealisasi ?? this.statusRealisasi,
    );
  }
}
