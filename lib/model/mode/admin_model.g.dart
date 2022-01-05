// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminResponse _$AdminResponseFromJson(Map<String, dynamic> json) =>
    AdminResponse(
      password: json['password'] as String,
      username: json['username'] as String,
    );

Map<String, dynamic> _$AdminResponseToJson(AdminResponse instance) =>
    <String, dynamic>{
      'password': instance.password,
      'username': instance.username,
    };
