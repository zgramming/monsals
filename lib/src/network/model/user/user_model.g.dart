// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    idUser: GlobalFunction.fromJsonStringToInteger(json['id_user']),
    username: json['username'] as String,
    password: json['password'] as String,
    sales: SalesModel.fromJson(json['sales'] as Map<String, dynamic>),
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id_user': GlobalFunction.toJsonStringFromInteger(instance.idUser),
      'username': instance.username,
      'password': instance.password,
      'sales': instance.sales,
      'status': instance.status,
    };
