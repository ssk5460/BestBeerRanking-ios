import 'dart:io';

import 'package:best_beer_ranking/data/model/converter/BoolConverter.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';
part 'category.g.dart';

@freezed
abstract class Category with _$Category {
  factory Category({
    required int id,
    required String title,
    required int recordedAt,
    required String hexColor,
    @BoolConverter() required bool isShowThumbnail,
    @BoolConverter() required bool isShowPoint,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
}
