// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Category _$$_CategoryFromJson(Map<String, dynamic> json) => _$_Category(
      id: json['id'] as int,
      title: json['title'] as String,
      recordedAt: json['recordedAt'] as int,
      hexColor: json['hexColor'] as String,
      isShowThumbnail:
          const BoolConverter().fromJson(json['isShowThumbnail'] as int),
      isShowPoint: const BoolConverter().fromJson(json['isShowPoint'] as int),
    );

Map<String, dynamic> _$$_CategoryToJson(_$_Category instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'recordedAt': instance.recordedAt,
      'hexColor': instance.hexColor,
      'isShowThumbnail': const BoolConverter().toJson(instance.isShowThumbnail),
      'isShowPoint': const BoolConverter().toJson(instance.isShowPoint),
    };
