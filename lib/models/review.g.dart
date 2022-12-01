// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      id: json['id'] as int,
      rating: (json['rating'] as num).toDouble(),
      date: json['date'] as String,
      comment: json['comment'] as String,
      name: json['name'] as String,
      anonymous: json['anonymous'] as bool,
      chatable: json['chatable'] as bool,
      dishIds: (json['dishIds'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'id': instance.id,
      'rating': instance.rating,
      'date': instance.date,
      'comment': instance.comment,
      'name': instance.name,
      'anonymous': instance.anonymous,
      'chatable': instance.chatable,
      'dishIds': instance.dishIds,
    };
