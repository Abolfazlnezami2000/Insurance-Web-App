// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponseModel _$UserResponseModelFromJson(Map<String, dynamic> json) =>
    UserResponseModel(
      id: json['id'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      email: json['email'] as String,
      image: json['image'] as String,
      date: json['date'] as String,
    );

Map<String, dynamic> _$UserResponseModelToJson(UserResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'password': instance.password,
      'image': instance.image,
      'date': instance.date,
      'email': instance.email,
    };
