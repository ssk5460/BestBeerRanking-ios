
import 'package:freezed_annotation/freezed_annotation.dart';

class BoolConverter implements JsonConverter<bool, int> {
  const BoolConverter();

  @override
  bool fromJson(int json) {
    return json == 1;
  }

  @override
  int toJson(bool object) {
    return object ? 1 : 0;
  }
}