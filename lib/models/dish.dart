import 'package:json_annotation/json_annotation.dart';

part 'dish.g.dart';

@JsonSerializable()
class Dish {
  int id;
  String name;
  double price;

  double? rating;

  @JsonKey(defaultValue: [])
  List<String>? imgUrl;

  @JsonKey(defaultValue: [])
  List<int>? allergyNoteIds;

  @JsonKey(defaultValue: [])
  List<int>? flavorIds;

  @JsonKey(defaultValue: [])
  List<int>? reviewIds;

  @JsonKey(defaultValue: [])
  List<int>? relatedReviewIds;

  Dish({
    required this.id,
    required this.name,
    required this.price,
    this.rating,
    this.imgUrl,
    this.allergyNoteIds,
    this.flavorIds,
    this.reviewIds,
    this.relatedReviewIds,
  });

  factory Dish.fromJson(Map<String, dynamic> json) => _$DishFromJson(json);

  Map<String, dynamic> toJson() => _$DishToJson(this);
}
