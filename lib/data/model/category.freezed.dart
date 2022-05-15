// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return _Category.fromJson(json);
}

/// @nodoc
class _$CategoryTearOff {
  const _$CategoryTearOff();

  _Category call(
      {required int id,
      required String title,
      required int recordedAt,
      required String hexColor,
      @BoolConverter() required bool isShowThumbnail,
      @BoolConverter() required bool isShowPoint}) {
    return _Category(
      id: id,
      title: title,
      recordedAt: recordedAt,
      hexColor: hexColor,
      isShowThumbnail: isShowThumbnail,
      isShowPoint: isShowPoint,
    );
  }

  Category fromJson(Map<String, Object?> json) {
    return Category.fromJson(json);
  }
}

/// @nodoc
const $Category = _$CategoryTearOff();

/// @nodoc
mixin _$Category {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  int get recordedAt => throw _privateConstructorUsedError;
  String get hexColor => throw _privateConstructorUsedError;
  @BoolConverter()
  bool get isShowThumbnail => throw _privateConstructorUsedError;
  @BoolConverter()
  bool get isShowPoint => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CategoryCopyWith<Category> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryCopyWith<$Res> {
  factory $CategoryCopyWith(Category value, $Res Function(Category) then) =
      _$CategoryCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String title,
      int recordedAt,
      String hexColor,
      @BoolConverter() bool isShowThumbnail,
      @BoolConverter() bool isShowPoint});
}

/// @nodoc
class _$CategoryCopyWithImpl<$Res> implements $CategoryCopyWith<$Res> {
  _$CategoryCopyWithImpl(this._value, this._then);

  final Category _value;
  // ignore: unused_field
  final $Res Function(Category) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? recordedAt = freezed,
    Object? hexColor = freezed,
    Object? isShowThumbnail = freezed,
    Object? isShowPoint = freezed,
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
      recordedAt: recordedAt == freezed
          ? _value.recordedAt
          : recordedAt // ignore: cast_nullable_to_non_nullable
              as int,
      hexColor: hexColor == freezed
          ? _value.hexColor
          : hexColor // ignore: cast_nullable_to_non_nullable
              as String,
      isShowThumbnail: isShowThumbnail == freezed
          ? _value.isShowThumbnail
          : isShowThumbnail // ignore: cast_nullable_to_non_nullable
              as bool,
      isShowPoint: isShowPoint == freezed
          ? _value.isShowPoint
          : isShowPoint // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$CategoryCopyWith<$Res> implements $CategoryCopyWith<$Res> {
  factory _$CategoryCopyWith(_Category value, $Res Function(_Category) then) =
      __$CategoryCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String title,
      int recordedAt,
      String hexColor,
      @BoolConverter() bool isShowThumbnail,
      @BoolConverter() bool isShowPoint});
}

/// @nodoc
class __$CategoryCopyWithImpl<$Res> extends _$CategoryCopyWithImpl<$Res>
    implements _$CategoryCopyWith<$Res> {
  __$CategoryCopyWithImpl(_Category _value, $Res Function(_Category) _then)
      : super(_value, (v) => _then(v as _Category));

  @override
  _Category get _value => super._value as _Category;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? recordedAt = freezed,
    Object? hexColor = freezed,
    Object? isShowThumbnail = freezed,
    Object? isShowPoint = freezed,
  }) {
    return _then(_Category(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      recordedAt: recordedAt == freezed
          ? _value.recordedAt
          : recordedAt // ignore: cast_nullable_to_non_nullable
              as int,
      hexColor: hexColor == freezed
          ? _value.hexColor
          : hexColor // ignore: cast_nullable_to_non_nullable
              as String,
      isShowThumbnail: isShowThumbnail == freezed
          ? _value.isShowThumbnail
          : isShowThumbnail // ignore: cast_nullable_to_non_nullable
              as bool,
      isShowPoint: isShowPoint == freezed
          ? _value.isShowPoint
          : isShowPoint // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Category implements _Category {
  _$_Category(
      {required this.id,
      required this.title,
      required this.recordedAt,
      required this.hexColor,
      @BoolConverter() required this.isShowThumbnail,
      @BoolConverter() required this.isShowPoint});

  factory _$_Category.fromJson(Map<String, dynamic> json) =>
      _$$_CategoryFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final int recordedAt;
  @override
  final String hexColor;
  @override
  @BoolConverter()
  final bool isShowThumbnail;
  @override
  @BoolConverter()
  final bool isShowPoint;

  @override
  String toString() {
    return 'Category(id: $id, title: $title, recordedAt: $recordedAt, hexColor: $hexColor, isShowThumbnail: $isShowThumbnail, isShowPoint: $isShowPoint)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Category &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality()
                .equals(other.recordedAt, recordedAt) &&
            const DeepCollectionEquality().equals(other.hexColor, hexColor) &&
            const DeepCollectionEquality()
                .equals(other.isShowThumbnail, isShowThumbnail) &&
            const DeepCollectionEquality()
                .equals(other.isShowPoint, isShowPoint));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(recordedAt),
      const DeepCollectionEquality().hash(hexColor),
      const DeepCollectionEquality().hash(isShowThumbnail),
      const DeepCollectionEquality().hash(isShowPoint));

  @JsonKey(ignore: true)
  @override
  _$CategoryCopyWith<_Category> get copyWith =>
      __$CategoryCopyWithImpl<_Category>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CategoryToJson(this);
  }
}

abstract class _Category implements Category {
  factory _Category(
      {required int id,
      required String title,
      required int recordedAt,
      required String hexColor,
      @BoolConverter() required bool isShowThumbnail,
      @BoolConverter() required bool isShowPoint}) = _$_Category;

  factory _Category.fromJson(Map<String, dynamic> json) = _$_Category.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  int get recordedAt;
  @override
  String get hexColor;
  @override
  @BoolConverter()
  bool get isShowThumbnail;
  @override
  @BoolConverter()
  bool get isShowPoint;
  @override
  @JsonKey(ignore: true)
  _$CategoryCopyWith<_Category> get copyWith =>
      throw _privateConstructorUsedError;
}
