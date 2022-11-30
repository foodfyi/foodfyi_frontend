import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  int id;
  int fromId;
  int direction;
  String userName;
  String text;
  String time;
  String avatarUrl;

  Message({
    required this.id,
    required this.fromId,
    required this.direction,
    required this.userName,
    required this.text,
    required this.time,
    required this.avatarUrl,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
