import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:best_beer_ranking/app.dart';
import 'package:best_beer_ranking/data/provider/shared_preference_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase
  await Firebase.initializeApp();
  // Remote config
  await RemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 10),
    minimumFetchInterval: Duration.zero,
  ));
  RemoteConfigValue(null, ValueSource.valueStatic);

  // Init and get SharedPreferences instance
  final sharedPreferences = await SharedPreferences.getInstance();

  if (kReleaseMode) {
    debugPrint = (message, {wrapWidth}) {};
  }

  runZonedGuarded(() {
    runApp(ProviderScope(
        overrides: [prefsProvider.overrideWithValue(sharedPreferences)],
        child: App()));
  }, (error, stackTrace) {
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}

