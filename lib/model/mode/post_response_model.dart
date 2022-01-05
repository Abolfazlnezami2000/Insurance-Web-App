import 'package:json_annotation/json_annotation.dart';

part 'post_response_model.g.dart';

@JsonSerializable()
class PostResponseModel {
  PostResponseModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.category,
  });

  final String id;
  final String title;
  final String price;
  final String image;
  final String description;
  final String category;

  factory PostResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PostResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostResponseModelToJson(this);

}