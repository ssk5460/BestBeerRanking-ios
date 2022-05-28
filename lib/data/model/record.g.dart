// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Record _$$_RecordFromJson(Map<String, dynamic> json) => _$_Record(
      id: json['id'] as int,
      title: json['title'] as String,
      memo: json['memo'] as String?,
      point: json['point'] as int?,
      ranking: json['ranking'] as int?,
      imageBase64String: json['imageBase64String'] as String?,
      recordedAt:
          const DateTimeIntConverter().fromJson(json['recordedAt'] as int?),
      categoryId: json['categoryId'] as int?,
    );

Map<String, dynamic> _$$_RecordToJson(_$_Record instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'memo': instance.memo,
      'point': instance.point,
      'ranking': instance.ranking,
      'imageBase64String': instance.imageBase64String,
      'recordedAt': const DateTimeIntConverter().toJson(instance.recordedAt),
      'categoryId': instance.categoryId,
    };
