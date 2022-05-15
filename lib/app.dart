import 'dart:io';

import 'package:best_beer_ranking/utils/ad_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:best_beer_ranking/app_config.dart';
import 'package:best_beer_ranking/l10n/l10n.dart';
import 'package:best_beer_ranking/navigation/app_route_delegate.dart';
import 'package:best_beer_ranking/navigation/app_route_parser.dart';
import 'package:best_beer_ranking/theme/app_theme.dart';

class App extends HookConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final themeMode = ref.watch(appThemeModeProvider);
    final locale = AppConfig.supportedLanguages.keys.elementAt(1);
    if (Platform.isIOS) {
      AdUtil.showRequestTrackingAuthorization();
    }
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: theme.data,
      darkTheme: AppTheme.dark().data,
      themeMode: themeMode,
      locale: Locale(locale),
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      routerDelegate: ref.watch(appRouteDelegateProvider),
      routeInformationParser: ref.watch(appRouteParserProvider),
    );
  }
}