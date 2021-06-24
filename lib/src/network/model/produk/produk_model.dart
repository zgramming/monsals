import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';
import 'package:json_annotation/json_annotation.dart';

part 'produk_model.g.dart';

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class ProdukModel extends Equatable {
  const ProdukModel({
    this.idProduk,
    this.kode = '',
    this.nama = '',
    this.exp = '',
    this.deskripsi = '',
    this.harga,
    this.stok,
    this.foto,
  });

  @JsonKey(
    toJson: GlobalFunction.toJsonStringFromInteger,
    fromJson: GlobalFunction.fromJsonStringToInteger,
  )
  final int? idProduk;
  final String kode;
  final String nama;
  final String exp;
  final String deskripsi;
  @JsonKey(
    toJson: GlobalFunction.toJsonStringFromInteger,
    fromJson: GlobalFunction.fromJsonStringToInteger,
  )
  final int? harga;
  @JsonKey(
    toJson: GlobalFunction.toJsonStringFromInteger,
    fromJson: GlobalFunction.fromJsonStringToInteger,
  )
  final int? stok;
  final String? foto;

  factory ProdukModel.fromJson(Map<String, dynamic> json) => _$ProdukModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProdukModelToJson(this);

  @override
  List get props {
    return [
      idProduk,
      kode,
      nama,
      exp,
      deskripsi,
      harga,
      stok,
      foto,
    ];
  }

  @override
  bool get stringify => true;

  ProdukModel copyWith({
    int? idProduk,
    String? kode,
    String? nama,
    String? exp,
    String? deskripsi,
    int? harga,
    int? stok,
    String? foto,
  }) {
    return ProdukModel(
      idProduk: idProduk ?? this.idProduk,
      kode: kode ?? this.kode,
      nama: nama ?? this.nama,
      exp: exp ?? this.exp,
      deskripsi: deskripsi ?? this.deskripsi,
      harga: harga ?? this.harga,
      stok: stok ?? this.stok,
      foto: foto ?? this.foto,
    );
  }
}

// @JsonKey(
//     toJson: GlobalFunction.toJsonStringFromInteger,
//     fromJson: GlobalFunction.fromJsonStringToInteger,
//   )

