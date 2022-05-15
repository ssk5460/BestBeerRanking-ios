// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'app_route_path.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AppRoutePathTearOff {
  const _$AppRoutePathTearOff();

  HomeRoute home() {
    return HomeRoute();
  }
}

/// @nodoc
const $AppRoutePath = _$AppRoutePathTearOff();

/// @nodoc
mixin _$AppRoutePath {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() home,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? home,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? home,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HomeRoute value) home,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(HomeRoute value)? home,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HomeRoute value)? home,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppRoutePathCopyWith<$Res> {
  factory $AppRoutePathCopyWith(
          AppRoutePath value, $Res Function(AppRoutePath) then) =
      _$AppRoutePathCopyWithImpl<$Res>;
}

/// @nodoc
class _$AppRoutePathCopyWithImpl<$Res> implements $AppRoutePathCopyWith<$Res> {
  _$AppRoutePathCopyWithImpl(this._value, this._then);

  final AppRoutePath _value;
  // ignore: unused_field
  final $Res Function(AppRoutePath) _then;
}

/// @nodoc
abstract class $HomeRouteCopyWith<$Res> {
  factory $HomeRouteCopyWith(HomeRoute value, $Res Function(HomeRoute) then) =
      _$HomeRouteCopyWithImpl<$Res>;
}

/// @nodoc
class _$HomeRouteCopyWithImpl<$Res> extends _$AppRoutePathCopyWithImpl<$Res>
    implements $HomeRouteCopyWith<$Res> {
  _$HomeRouteCopyWithImpl(HomeRoute _value, $Res Function(HomeRoute) _then)
      : super(_value, (v) => _then(v as HomeRoute));

  @override
  HomeRoute get _value => super._value as HomeRoute;
}

/// @nodoc

class _$HomeRoute implements HomeRoute {
  _$HomeRoute();

  @override
  String toString() {
    return 'AppRoutePath.home()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is HomeRoute);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() home,
  }) {
    return home();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? home,
  }) {
    return home?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? home,
    required TResult orElse(),
  }) {
    if (home != null) {
      return home();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HomeRoute value) home,
  }) {
    return home(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(HomeRoute value)? home,
  }) {
    return home?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HomeRoute value)? home,
    required TResult orElse(),
  }) {
    if (home != null) {
      return home(this);
    }
    return orElse();
  }
}

abstract class HomeRoute implements AppRoutePath {
  factory HomeRoute() = _$HomeRoute;
}
