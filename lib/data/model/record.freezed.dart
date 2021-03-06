// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Record _$RecordFromJson(Map<String, dynamic> json) {
  return _Record.fromJson(json);
}

/// @nodoc
class _$RecordTearOff {
  const _$RecordTearOff();

  _Record call(
      {required int id,
      required String title,
      String? memo,
      int? ranking,
      double? evaluation,
      double? sharp_point,
      double? acidity_point,
      double? bitter_point,
      double? sweet_point,
      double? rich_point,
      double? fragrance_point,
      String? imageBase64String,
      @DateTimeIntConverter() DateTime? recordedAt,
      int? categoryId}) {
    return _Record(
      id: id,
      title: title,
      memo: memo,
      ranking: ranking,
      evaluation: evaluation,
      sharp_point: sharp_point,
      acidity_point: acidity_point,
      bitter_point: bitter_point,
      sweet_point: sweet_point,
      rich_point: rich_point,
      fragrance_point: fragrance_point,
      imageBase64String: imageBase64String,
      recordedAt: recordedAt,
      categoryId: categoryId,
    );
  }

  Record fromJson(Map<String, Object?> json) {
    return Record.fromJson(json);
  }
}

/// @nodoc
const $Record = _$RecordTearOff();

/// @nodoc
mixin _$Record {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get memo => throw _privateConstructorUsedError;
  int? get ranking => throw _privateConstructorUsedError;
  double? get evaluation => throw _privateConstructorUsedError;
  double? get sharp_point => throw _privateConstructorUsedError;
  double? get acidity_point => throw _privateConstructorUsedError;
  double? get bitter_point => throw _privateConstructorUsedError;
  double? get sweet_point => throw _privateConstructorUsedError;
  double? get rich_point => throw _privateConstructorUsedError;
  double? get fragrance_point => throw _privateConstructorUsedError;
  String? get imageBase64String => throw _privateConstructorUsedError;
  @DateTimeIntConverter()
  DateTime? get recordedAt => throw _privateConstructorUsedError;
  int? get categoryId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecordCopyWith<Record> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordCopyWith<$Res> {
  factory $RecordCopyWith(Record value, $Res Function(Record) then) =
      _$RecordCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String title,
      String? memo,
      int? ranking,
      double? evaluation,
      double? sharp_point,
      double? acidity_point,
      double? bitter_point,
      double? sweet_point,
      double? rich_point,
      double? fragrance_point,
      String? imageBase64String,
      @DateTimeIntConverter() DateTime? recordedAt,
      int? categoryId});
}

/// @nodoc
class _$RecordCopyWithImpl<$Res> implements $RecordCopyWith<$Res> {
  _$RecordCopyWithImpl(this._value, this._then);

  final Record _value;
  // ignore: unused_field
  final $Res Function(Record) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? memo = freezed,
    Object? ranking = freezed,
    Object? evaluation = freezed,
    Object? sharp_point = freezed,
    Object? acidity_point = freezed,
    Object? bitter_point = freezed,
    Object? sweet_point = freezed,
    Object? rich_point = freezed,
    Object? fragrance_point = freezed,
    Object? imageBase64String = freezed,
    Object? recordedAt = freezed,
    Object? categoryId = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      memo: memo == freezed
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
      ranking: ranking == freezed
          ? _value.ranking
          : ranking // ignore: cast_nullable_to_non_nullable
              as int?,
      evaluation: evaluation == freezed
          ? _value.evaluation
          : evaluation // ignore: cast_nullable_to_non_nullable
              as double?,
      sharp_point: sharp_point == freezed
          ? _value.sharp_point
          : sharp_point // ignore: cast_nullable_to_non_nullable
              as double?,
      acidity_point: acidity_point == freezed
          ? _value.acidity_point
          : acidity_point // ignore: cast_nullable_to_non_nullable
              as double?,
      bitter_point: bitter_point == freezed
          ? _value.bitter_point
          : bitter_point // ignore: cast_nullable_to_non_nullable
              as double?,
      sweet_point: sweet_point == freezed
          ? _value.sweet_point
          : sweet_point // ignore: cast_nullable_to_non_nullable
              as double?,
      rich_point: rich_point == freezed
          ? _value.rich_point
          : rich_point // ignore: cast_nullable_to_non_nullable
              as double?,
      fragrance_point: fragrance_point == freezed
          ? _value.fragrance_point
          : fragrance_point // ignore: cast_nullable_to_non_nullable
              as double?,
      imageBase64String: imageBase64String == freezed
          ? _value.imageBase64String
          : imageBase64String // ignore: cast_nullable_to_non_nullable
              as String?,
      recordedAt: recordedAt == freezed
          ? _value.recordedAt
          : recordedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      categoryId: categoryId == freezed
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$RecordCopyWith<$Res> implements $RecordCopyWith<$Res> {
  factory _$RecordCopyWith(_Record value, $Res Function(_Record) then) =
      __$RecordCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String title,
      String? memo,
      int? ranking,
      double? evaluation,
      double? sharp_point,
      double? acidity_point,
      double? bitter_point,
      double? sweet_point,
      double? rich_point,
      double? fragrance_point,
      String? imageBase64String,
      @DateTimeIntConverter() DateTime? recordedAt,
      int? categoryId});
}

/// @nodoc
class __$RecordCopyWithImpl<$Res> extends _$RecordCopyWithImpl<$Res>
    implements _$RecordCopyWith<$Res> {
  __$RecordCopyWithImpl(_Record _value, $Res Function(_Record) _then)
      : super(_value, (v) => _then(v as _Record));

  @override
  _Record get _value => super._value as _Record;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? memo = freezed,
    Object? ranking = freezed,
    Object? evaluation = freezed,
    Object? sharp_point = freezed,
    Object? acidity_point = freezed,
    Object? bitter_point = freezed,
    Object? sweet_point = freezed,
    Object? rich_point = freezed,
    Object? fragrance_point = freezed,
    Object? imageBase64String = freezed,
    Object? recordedAt = freezed,
    Object? categoryId = freezed,
  }) {
    return _then(_Record(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      memo: memo == freezed
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
      ranking: ranking == freezed
          ? _value.ranking
          : ranking // ignore: cast_nullable_to_non_nullable
              as int?,
      evaluation: evaluation == freezed
          ? _value.evaluation
          : evaluation // ignore: cast_nullable_to_non_nullable
              as double?,
      sharp_point: sharp_point == freezed
          ? _value.sharp_point
          : sharp_point // ignore: cast_nullable_to_non_nullable
              as double?,
      acidity_point: acidity_point == freezed
          ? _value.acidity_point
          : acidity_point // ignore: cast_nullable_to_non_nullable
              as double?,
      bitter_point: bitter_point == freezed
          ? _value.bitter_point
          : bitter_point // ignore: cast_nullable_to_non_nullable
              as double?,
      sweet_point: sweet_point == freezed
          ? _value.sweet_point
          : sweet_point // ignore: cast_nullable_to_non_nullable
              as double?,
      rich_point: rich_point == freezed
          ? _value.rich_point
          : rich_point // ignore: cast_nullable_to_non_nullable
              as double?,
      fragrance_point: fragrance_point == freezed
          ? _value.fragrance_point
          : fragrance_point // ignore: cast_nullable_to_non_nullable
              as double?,
      imageBase64String: imageBase64String == freezed
          ? _value.imageBase64String
          : imageBase64String // ignore: cast_nullable_to_non_nullable
              as String?,
      recordedAt: recordedAt == freezed
          ? _value.recordedAt
          : recordedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      categoryId: categoryId == freezed
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Record implements _Record {
  _$_Record(
      {required this.id,
      required this.title,
      this.memo,
      this.ranking,
      this.evaluation,
      this.sharp_point,
      this.acidity_point,
      this.bitter_point,
      this.sweet_point,
      this.rich_point,
      this.fragrance_point,
      this.imageBase64String,
      @DateTimeIntConverter() this.recordedAt,
      this.categoryId});

  factory _$_Record.fromJson(Map<String, dynamic> json) =>
      _$$_RecordFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String? memo;
  @override
  final int? ranking;
  @override
  final double? evaluation;
  @override
  final double? sharp_point;
  @override
  final double? acidity_point;
  @override
  final double? bitter_point;
  @override
  final double? sweet_point;
  @override
  final double? rich_point;
  @override
  final double? fragrance_point;
  @override
  final String? imageBase64String;
  @override
  @DateTimeIntConverter()
  final DateTime? recordedAt;
  @override
  final int? categoryId;

  @override
  String toString() {
    return 'Record(id: $id, title: $title, memo: $memo, ranking: $ranking, evaluation: $evaluation, sharp_point: $sharp_point, acidity_point: $acidity_point, bitter_point: $bitter_point, sweet_point: $sweet_point, rich_point: $rich_point, fragrance_point: $fragrance_point, imageBase64String: $imageBase64String, recordedAt: $recordedAt, categoryId: $categoryId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Record &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.memo, memo) &&
            const DeepCollectionEquality().equals(other.ranking, ranking) &&
            const DeepCollectionEquality()
                .equals(other.evaluation, evaluation) &&
            const DeepCollectionEquality()
                .equals(other.sharp_point, sharp_point) &&
            const DeepCollectionEquality()
                .equals(other.acidity_point, acidity_point) &&
            const DeepCollectionEquality()
                .equals(other.bitter_point, bitter_point) &&
            const DeepCollectionEquality()
                .equals(other.sweet_point, sweet_point) &&
            const DeepCollectionEquality()
                .equals(other.rich_point, rich_point) &&
            const DeepCollectionEquality()
                .equals(other.fragrance_point, fragrance_point) &&
            const DeepCollectionEquality()
                .equals(other.imageBase64String, imageBase64String) &&
            const DeepCollectionEquality()
                .equals(other.recordedAt, recordedAt) &&
            const DeepCollectionEquality()
                .equals(other.categoryId, categoryId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(memo),
      const DeepCollectionEquality().hash(ranking),
      const DeepCollectionEquality().hash(evaluation),
      const DeepCollectionEquality().hash(sharp_point),
      const DeepCollectionEquality().hash(acidity_point),
      const DeepCollectionEquality().hash(bitter_point),
      const DeepCollectionEquality().hash(sweet_point),
      const DeepCollectionEquality().hash(rich_point),
      const DeepCollectionEquality().hash(fragrance_point),
      const DeepCollectionEquality().hash(imageBase64String),
      const DeepCollectionEquality().hash(recordedAt),
      const DeepCollectionEquality().hash(categoryId));

  @JsonKey(ignore: true)
  @override
  _$RecordCopyWith<_Record> get copyWith =>
      __$RecordCopyWithImpl<_Record>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RecordToJson(this);
  }
}

abstract class _Record implements Record {
  factory _Record(
      {required int id,
      required String title,
      String? memo,
      int? ranking,
      double? evaluation,
      double? sharp_point,
      double? acidity_point,
      double? bitter_point,
      double? sweet_point,
      double? rich_point,
      double? fragrance_point,
      String? imageBase64String,
      @DateTimeIntConverter() DateTime? recordedAt,
      int? categoryId}) = _$_Record;

  factory _Record.fromJson(Map<String, dynamic> json) = _$_Record.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String? get memo;
  @override
  int? get ranking;
  @override
  double? get evaluation;
  @override
  double? get sharp_point;
  @override
  double? get acidity_point;
  @override
  double? get bitter_point;
  @override
  double? get sweet_point;
  @override
  double? get rich_point;
  @override
  double? get fragrance_point;
  @override
  String? get imageBase64String;
  @override
  @DateTimeIntConverter()
  DateTime? get recordedAt;
  @override
  int? get categoryId;
  @override
  @JsonKey(ignore: true)
  _$RecordCopyWith<_Record> get copyWith => throw _privateConstructorUsedError;
}
