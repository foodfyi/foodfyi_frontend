// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dish.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dish _$DishFromJson(Map<String, dynamic> json) => Dish(
      id: json['id'] as int,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num?)?.toDouble(),
      imgUrl: (json['imgUrl'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      allergyNoteIds: (json['allergyNoteIds'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          [],
      flavorIds: (json['flavorIds'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          [],
      reviewIds: (json['reviewIds'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          [],
      relatedReviewIds: (json['relatedReviewIds'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          [],
      modified: json['modified'] as bool? ?? false,
      activeImgPage: json['activeImgPage'] as int? ?? 0,
    );

Map<String, dynamic> _$DishToJson(Dish instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'rating': instance.rating,
      'imgUrl': instance.imgUrl,
      'allergyNoteIds': instance.allergyNoteIds,
      'flavorIds': instance.flavorIds,
      'reviewIds': instance.reviewIds,
      'relatedReviewIds': instance.relatedReviewIds,
      'modified': instance.modified,
      'activeImgPage': instance.activeImgPage,
    };
