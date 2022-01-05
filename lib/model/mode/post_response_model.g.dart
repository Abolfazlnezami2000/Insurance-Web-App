// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostResponseModel _$PostResponseModelFromJson(Map<String, dynamic> json) =>
    PostResponseModel(
      id: json['id'] as String,
      title: json['title'] as String,
      price: json['price'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      category: json['category'] as String,
    );

Map<String, dynamic> _$PostResponseModelToJson(PostResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'image': instance.image,
      'description': instance.description,
      'category': instance.category,
    };
