import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';
import 'package:json_annotation/json_annotation.dart';

import '../my_network.dart';

part 'penjualan_model.g.dart';

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class PenjualanModel extends Equatable {
  const PenjualanModel({
    this.idPenjualan,
    this.jml,
    this.total,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.rencana = const RencanaModel(),
    this.produk = const ProdukModel(),
  });

  @JsonKey(
    toJson: GlobalFunction.toJsonStringFromInteger,
    fromJson: GlobalFunction.fromJsonStringToInteger,
  )
  final int? idPenjualan;
  @JsonKey(
    toJson: GlobalFunction.toJsonStringFromInteger,
    fromJson: GlobalFunction.fromJsonStringToInteger,
  )
  final int? jml;
  @JsonKey(
    toJson: GlobalFunction.toJsonStringFromInteger,
    fromJson: GlobalFunction.fromJsonStringToInteger,
  )
  final int? total;
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

  @JsonKey(name: 'rencana')
  final RencanaModel rencana;
  @JsonKey(name: 'produk')
  final ProdukModel produk;

  factory PenjualanModel.fromJson(Map<String, dynamic> json) => _$PenjualanModelFromJson(json);
  Map<String, dynamic> toJson() => _$PenjualanModelToJson(this);

  @override
  List get props {
    return [
      idPenjualan,
      jml,
      total,
      createdBy,
      createdAt,
      updatedBy,
      updatedAt,
      rencana,
      produk,
    ];
  }

  @override
  bool get stringify => true;

  PenjualanModel copyWith({
    int? idPenjualan,
    int? jml,
    int? total,
    int? createdBy,
    DateTime? createdAt,
    int? updatedBy,
    DateTime? updatedAt,
    RencanaModel? rencana,
    ProdukModel? produk,
  }) {
    return PenjualanModel(
      idPenjualan: idPenjualan ?? this.idPenjualan,
      jml: jml ?? this.jml,
      total: total ?? this.total,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedBy: updatedBy ?? this.updatedBy,
      updatedAt: updatedAt ?? this.updatedAt,
      rencana: rencana ?? this.rencana,
      produk: produk ?? this.produk,
    );
  }
}

// @JsonKey(
//     toJson: GlobalFunction.toJsonStringFromInteger,
//     fromJson: GlobalFunction.fromJsonStringToInteger,
//   )

