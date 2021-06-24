import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';
import 'package:json_annotation/json_annotation.dart';

part 'kategori_produk_model.g.dart';

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class KategoriProdukModel extends Equatable {
  const KategoriProdukModel({
    this.idKategoriP,
    this.nama,
    this.kodeKategoriP,
    this.status,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  @JsonKey(
    toJson: GlobalFunction.toJsonStringFromInteger,
    fromJson: GlobalFunction.fromJsonStringToInteger,
    name: 'id_kategoriP',
  )
  final int? idKategoriP;
  final String? nama;
  @JsonKey(name: 'kode_kategoriP')
  final String? kodeKategoriP;
  final String? status;
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

  factory KategoriProdukModel.fromJson(Map<String, dynamic> json) =>
      _$KategoriProdukModelFromJson(json);
  Map<String, dynamic> toJson() => _$KategoriProdukModelToJson(this);

  @override
  List get props {
    return [
      idKategoriP,
      nama,
      kodeKategoriP,
      status,
      createdBy,
      createdAt,
      updatedBy,
      updatedAt,
    ];
  }

  @override
  bool get stringify => true;

  KategoriProdukModel copyWith({
    int? idKategoriP,
    String? nama,
    String? kodeKategoriP,
    String? status,
    int? createdBy,
    DateTime? createdAt,
    int? updatedBy,
    DateTime? updatedAt,
  }) {
    return KategoriProdukModel(
      idKategoriP: idKategoriP ?? this.idKategoriP,
      nama: nama ?? this.nama,
      kodeKategoriP: kodeKategoriP ?? this.kodeKategoriP,
      status: status ?? this.status,
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