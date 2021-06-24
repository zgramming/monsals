import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';
import 'package:json_annotation/json_annotation.dart';

import '../my_network.dart';

part 'sales_model.g.dart';

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class SalesModel extends Equatable {
  const SalesModel({
    this.idSales,
    this.nama = '',
    this.kodeSales = '',
    this.hp = '',
    this.email = '',
    this.alamat = '',
    this.status = '',
    this.foto,
    this.cabang = const CabangModel(),
  });

  @JsonKey(
    toJson: GlobalFunction.toJsonStringFromInteger,
    fromJson: GlobalFunction.fromJsonStringToInteger,
  )
  final int? idSales;
  final String? nama;
  final String? kodeSales;
  final String? hp;
  final String? email;
  final String? alamat;
  final String? status;
  final String? foto;
  @JsonKey(name: 'cabang')
  final CabangModel cabang;

  factory SalesModel.fromJson(Map<String, dynamic> json) => _$SalesModelFromJson(json);
  Map<String, dynamic> toJson() => _$SalesModelToJson(this);

  @override
  List get props {
    return [
      idSales,
      nama,
      kodeSales,
      hp,
      email,
      alamat,
      status,
      foto,
      cabang,
    ];
  }

  @override
  bool get stringify => true;

  SalesModel copyWith({
    int? idSales,
    String? nama,
    String? kodeSales,
    String? hp,
    String? email,
    String? alamat,
    String? status,
    String? foto,
    CabangModel? cabang,
  }) {
    return SalesModel(
      idSales: idSales ?? this.idSales,
      nama: nama ?? this.nama,
      kodeSales: kodeSales ?? this.kodeSales,
      hp: hp ?? this.hp,
      email: email ?? this.email,
      alamat: alamat ?? this.alamat,
      status: status ?? this.status,
      foto: foto ?? this.foto,
      cabang: cabang ?? this.cabang,
    );
  }
}
