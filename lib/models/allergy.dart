import 'package:json_annotation/json_annotation.dart';

part 'allergy.g.dart';

@JsonSerializable()
class Allergy {
  int id;
  String name;

  Allergy({
    required this.id,
    required this.name,
  });

  factory Allergy.fromJson(Map<String, dynamic> json) =>
      _$AllergyFromJson(json);

  Map<String, dynamic> toJson() => _$AllergyToJson(this);
}
