import 'dart:io';

import 'package:best_beer_ranking/data/model/converter/DateTimeIntConverter.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:best_beer_ranking/utils/utils.dart';

part 'record.freezed.dart';
part 'record.g.dart';

@freezed
abstract class Record with _$Record {
  factory Record({
    required int id,
    required String title,
    String? memo,
    int? point,
    int? ranking,
    @RecordImageConverter() Image? image,
    @DateTimeIntConverter() DateTime? recordedAt,
    int? categoryId,
  }) = _Record;

  factory Record.fromJson(Map<String, dynamic> json) => _$RecordFromJson(json);
}

class RecordImageConverter implements JsonConverter<Image?, String?> {
  const RecordImageConverter();

  @override
  Image? fromJson(String? value) {
    if (value == null) {
      return null;
    }
    return Utils.imageFromBase64String(value);
  }

  @override
  String? toJson(Image? image) {
    return null;
  }
}