import 'package:best_beer_ranking/data/model/category.dart';
import 'package:best_beer_ranking/data/model/converter/DateTimeIntConverter.dart';
import 'package:best_beer_ranking/data/model/record.dart';
import 'package:best_beer_ranking/data/model/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ranking.freezed.dart';
part 'ranking.g.dart';

@freezed
abstract class Ranking with _$Ranking {
  factory Ranking({
    required User user,
    required String userId,
    required Category category,
    required List<Record> records,
    @DateTimeIntConverter() DateTime? updatedAt,
  }) = _Ranking;

  factory Ranking.fromJson(Map<String, dynamic> json) => _$RankingFromJson(json);
}
