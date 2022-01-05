import 'package:json_annotation/json_annotation.dart';

part 'admin_model.g.dart';

@JsonSerializable()
class AdminResponse {
  AdminResponse({
    required this.password,
    required this.username,
    // required this.id,
  });

  final String password;
  final String username;
  // final String id;

  factory AdminResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminResponseToJson(this);

}