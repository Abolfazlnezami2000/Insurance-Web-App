import 'package:json_annotation/json_annotation.dart';

part 'data_model.g.dart';

@JsonSerializable()
class DataResponse {
  DataResponse({
    required this.fullName,
    required this.email,
    required this.description,
    required this.id,
  });

  final String fullName;
  final String email;
  final String description;
  final String id;

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);

}
