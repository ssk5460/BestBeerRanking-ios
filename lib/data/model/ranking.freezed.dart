// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'ranking.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Ranking _$RankingFromJson(Map<String, dynamic> json) {
  return _Ranking.fromJson(json);
}

/// @nodoc
class _$RankingTearOff {
  const _$RankingTearOff();

  _Ranking call(
      {required User user,
      required String userId,
      required Category category,
      required List<Record> records,
      @DateTimeIntConverter() DateTime? updatedAt}) {
    return _Ranking(
      user: user,
      userId: userId,
      category: category,
      records: records,
      updatedAt: updatedAt,
    );
  }

  Ranking fromJson(Map<String, Object?> json) {
    return Ranking.fromJson(json);
  }
}

/// @nodoc
const $Ranking = _$RankingTearOff();

/// @nodoc
mixin _$Ranking {
  User get user => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  Category get category => throw _privateConstructorUsedError;
  List<Record> get records => throw _privateConstructorUsedError;
  @DateTimeIntConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RankingCopyWith<Ranking> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RankingCopyWith<$Res> {
  factory $RankingCopyWith(Ranking value, $Res Function(Ranking) then) =
      _$RankingCopyWithImpl<$Res>;
  $Res call(
      {User user,
      String userId,
      Category category,
      List<Record> records,
      @DateTimeIntConverter() DateTime? updatedAt});

  $UserCopyWith<$Res> get user;
  $CategoryCopyWith<$Res> get category;
}

/// @nodoc
class _$RankingCopyWithImpl<$Res> implements $RankingCopyWith<$Res> {
  _$RankingCopyWithImpl(this._value, this._then);

  final Ranking _value;
  // ignore: unused_field
  final $Res Function(Ranking) _then;

  @override
  $Res call({
    Object? user = freezed,
    Object? userId = freezed,
    Object? category = freezed,
    Object? records = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      category: category == freezed
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category,
      records: records == freezed
          ? _value.records
          : records // ignore: cast_nullable_to_non_nullable
              as List<Record>,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }

  @override
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }

  @override
  $CategoryCopyWith<$Res> get category {
    return $CategoryCopyWith<$Res>(_value.category, (value) {
      return _then(_value.copyWith(category: value));
    });
  }
}

/// @nodoc
abstract class _$RankingCopyWith<$Res> implements $RankingCopyWith<$Res> {
  factory _$RankingCopyWith(_Ranking value, $Res Function(_Ranking) then) =
      __$RankingCopyWithImpl<$Res>;
  @override
  $Res call(
      {User user,
      String userId,
      Category category,
      List<Record> records,
      @DateTimeIntConverter() DateTime? updatedAt});

  @override
  $UserCopyWith<$Res> get user;
  @override
  $CategoryCopyWith<$Res> get category;
}

/// @nodoc
class __$RankingCopyWithImpl<$Res> extends _$RankingCopyWithImpl<$Res>
    implements _$RankingCopyWith<$Res> {
  __$RankingCopyWithImpl(_Ranking _value, $Res Function(_Ranking) _then)
      : super(_value, (v) => _then(v as _Ranking));

  @override
  _Ranking get _value => super._value as _Ranking;

  @override
  $Res call({
    Object? user = freezed,
    Object? userId = freezed,
    Object? category = freezed,
    Object? records = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_Ranking(
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      category: category == freezed
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category,
      records: records == freezed
          ? _value.records
          : records // ignore: cast_nullable_to_non_nullable
              as List<Record>,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Ranking implements _Ranking {
  _$_Ranking(
      {required this.user,
      required this.userId,
      required this.category,
      required this.records,
      @DateTimeIntConverter() this.updatedAt});

  factory _$_Ranking.fromJson(Map<String, dynamic> json) =>
      _$$_RankingFromJson(json);

  @override
  final User user;
  @override
  final String userId;
  @override
  final Category category;
  @override
  final List<Record> records;
  @override
  @DateTimeIntConverter()
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Ranking(user: $user, userId: $userId, category: $category, records: $records, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Ranking &&
            const DeepCollectionEquality().equals(other.user, user) &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality().equals(other.category, category) &&
            const DeepCollectionEquality().equals(other.records, records) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(user),
      const DeepCollectionEquality().hash(userId),
      const DeepCollectionEquality().hash(category),
      const DeepCollectionEquality().hash(records),
      const DeepCollectionEquality().hash(updatedAt));

  @JsonKey(ignore: true)
  @override
  _$RankingCopyWith<_Ranking> get copyWith =>
      __$RankingCopyWithImpl<_Ranking>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RankingToJson(this);
  }
}

abstract class _Ranking implements Ranking {
  factory _Ranking(
      {required User user,
      required String userId,
      required Category category,
      required List<Record> records,
      @DateTimeIntConverter() DateTime? updatedAt}) = _$_Ranking;

  factory _Ranking.fromJson(Map<String, dynamic> json) = _$_Ranking.fromJson;

  @override
  User get user;
  @override
  String get userId;
  @override
  Category get category;
  @override
  List<Record> get records;
  @override
  @DateTimeIntConverter()
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$RankingCopyWith<_Ranking> get copyWith =>
      throw _privateConstructorUsedError;
}
