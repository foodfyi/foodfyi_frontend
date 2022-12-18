// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map<String, dynamic> json) => Chat(
      id: json['id'] as int,
      userName: json['userName'] as String,
      reviewId: json['reviewId'] as int,
      missingCnt: json['missingCnt'] as int,
      lastTime: json['lastTime'] as int,
      avatarUrl: json['avatarUrl'] as String,
    );

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'reviewId': instance.reviewId,
      'missingCnt': instance.missingCnt,
      'lastTime': instance.lastTime,
      'avatarUrl': instance.avatarUrl,
    };
