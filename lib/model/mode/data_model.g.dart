// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataResponse _$DataResponseFromJson(Map<String, dynamic> json) => DataResponse(
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      description: json['description'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$DataResponseToJson(DataResponse instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'email': instance.email,
      'description': instance.description,
      'id': instance.id,
    };
