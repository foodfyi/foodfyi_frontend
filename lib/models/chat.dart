import 'package:json_annotation/json_annotation.dart';

part 'chat.g.dart';

@JsonSerializable()
class Chat {
  int id;
  String userName;
  int missingCnt;
  String lastTime;
  String avatarUrl;

  Chat({
    required this.id,
    required this.userName,
    required this.missingCnt,
    required this.lastTime,
    required this.avatarUrl,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);

  Map<String, dynamic> toJson() => _$ChatToJson(this);
}
