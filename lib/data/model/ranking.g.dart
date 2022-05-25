// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ranking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Ranking _$$_RankingFromJson(Map<String, dynamic> json) => _$_Ranking(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      userId: json['userId'] as String,
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
      records: (json['records'] as List<dynamic>)
          .map((e) => Record.fromJson(e as Map<String, dynamic>))
          .toList(),
      updatedAt:
          const DateTimeIntConverter().fromJson(json['updatedAt'] as int?),
    );

Map<String, dynamic> _$$_RankingToJson(_$_Ranking instance) =>
    <String, dynamic>{
      'user': instance.user,
      'userId': instance.userId,
      'category': instance.category,
      'records': instance.records,
      'updatedAt': const DateTimeIntConverter().toJson(instance.updatedAt),
    };
