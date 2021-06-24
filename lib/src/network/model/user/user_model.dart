import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';
import 'package:json_annotation/json_annotation.dart';

import '../my_network.dart';

part 'user_model.g.dart';

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class UserModel extends Equatable {
  const UserModel({
    this.idUser,
    this.username = '',
    this.password = '',
    this.sales = const SalesModel(),
    this.status = '',
  });

  @JsonKey(
    toJson: GlobalFunction.toJsonStringFromInteger,
    fromJson: GlobalFunction.fromJsonStringToInteger,
  )
  final int? idUser;
  final String username;
  final String password;

  @JsonKey(name: 'sales')
  final SalesModel sales;
  final String status;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List get props {
    return [
      idUser,
      username,
      password,
      sales,
      status,
    ];
  }

  @override
  bool get stringify => true;

  UserModel copyWith({
    int? idUser,
    String? username,
    String? password,
    SalesModel? sales,
    String? status,
  }) {
    return UserModel(
      idUser: idUser ?? this.idUser,
      username: username ?? this.username,
      password: password ?? this.password,
      sales: sales ?? this.sales,
      status: status ?? this.status,
    );
  }
}
