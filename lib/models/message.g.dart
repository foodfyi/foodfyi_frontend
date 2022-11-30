// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      id: json['id'] as int,
      fromId: json['fromId'] as int,
      direction: json['direction'] as int,
      userName: json['userName'] as String,
      text: json['text'] as String,
      time: json['time'] as String,
      avatarUrl: json['avatarUrl'] as String,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'fromId': instance.fromId,
      'direction': instance.direction,
      'userName': instance.userName,
      'text': instance.text,
      'time': instance.time,
      'avatarUrl': instance.avatarUrl,
    };
