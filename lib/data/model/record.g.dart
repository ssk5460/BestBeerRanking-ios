// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Record _$$_RecordFromJson(Map<String, dynamic> json) => _$_Record(
      id: json['id'] as int,
      title: json['title'] as String,
      memo: json['memo'] as String?,
      ranking: json['ranking'] as int?,
      evaluation: (json['evaluation'] as num?)?.toDouble(),
      sharp_point: (json['sharp_point'] as num?)?.toDouble(),
      acidity_point: (json['acidity_point'] as num?)?.toDouble(),
      bitter_point: (json['bitter_point'] as num?)?.toDouble(),
      sweet_point: (json['sweet_point'] as num?)?.toDouble(),
      rich_point: (json['rich_point'] as num?)?.toDouble(),
      fragrance_point: (json['fragrance_point'] as num?)?.toDouble(),
      imageBase64String: json['imageBase64String'] as String?,
      recordedAt:
          const DateTimeIntConverter().fromJson(json['recordedAt'] as int?),
      categoryId: json['categoryId'] as int?,
    );

Map<String, dynamic> _$$_RecordToJson(_$_Record instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'memo': instance.memo,
      'ranking': instance.ranking,
      'evaluation': instance.evaluation,
      'sharp_point': instance.sharp_point,
      'acidity_point': instance.acidity_point,
      'bitter_point': instance.bitter_point,
      'sweet_point': instance.sweet_point,
      'rich_point': instance.rich_point,
      'fragrance_point': instance.fragrance_point,
      'imageBase64String': instance.imageBase64String,
      'recordedAt': const DateTimeIntConverter().toJson(instance.recordedAt),
      'categoryId': instance.categoryId,
    };
