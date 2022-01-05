import 'package:json_annotation/json_annotation.dart';

part 'user_response_model.g.dart';

@JsonSerializable()
class UserResponseModel {
  UserResponseModel({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.image,
    required this.date,
  });

  final String id;
  final String username;
  final String password;
  final String image;
  final String date;
  final String email;

  factory UserResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseModelToJson(this);

}