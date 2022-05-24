
import 'package:freezed_annotation/freezed_annotation.dart';

class DateTimeIntConverter implements JsonConverter<DateTime?, int?> {
  const DateTimeIntConverter();

  @override
  DateTime? fromJson(int? json) {
    if (json == null) {
      return DateTime.fromMillisecondsSinceEpoch(0);
    }
    return DateTime.fromMillisecondsSinceEpoch(json);
  }

  @override
  int? toJson(DateTime? object) {
    if (object == null) {
      return null;
    }
    return object.millisecondsSinceEpoch;
  }
}