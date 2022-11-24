import 'package:json_annotation/json_annotation.dart';

part 'review.g.dart';

@JsonSerializable()
class Review {
  int id;
  double rating;
  String date;
  String comment;
  String name;
  bool anonymous;
  List<int> dishIds;

  Review({
    required this.id,
    required this.rating,
    required this.date,
    required this.comment,
    required this.name,
    required this.anonymous,
    required this.dishIds,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}
