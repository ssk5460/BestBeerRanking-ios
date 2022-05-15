import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app_route_path.dart';

final appRouteParserProvider =
    Provider<AppRouteParser>((_) => AppRouteParser());

class AppRouteParser extends RouteInformationParser<AppRoutePath> {
  @override
  Future<AppRoutePath> parseRouteInformation(
          RouteInformation routeInformation) async =>
      SynchronousFuture(HomeRoute());
}
