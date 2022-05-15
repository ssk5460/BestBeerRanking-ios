import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_route_path.freezed.dart';

@freezed
class AppRoutePath with _$AppRoutePath {
  factory AppRoutePath.home() = HomeRoute;
}
