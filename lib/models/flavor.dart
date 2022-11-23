import 'package:json_annotation/json_annotation.dart';

part 'flavor.g.dart';

@JsonSerializable()
class Flavor {
  int id;
  String name;

  Flavor({
    required this.id,
    required this.name,
  });

  factory Flavor.fromJson(Map<String, dynamic> json) => _$FlavorFromJson(json);

  Map<String, dynamic> toJson() => _$FlavorToJson(this);
}
