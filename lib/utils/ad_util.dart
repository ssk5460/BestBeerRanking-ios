import 'package:flutter/services.dart';

class AdUtil {
  static void showRequestTrackingAuthorization() async {
    final MethodChannel _methodChannel =
        MethodChannel('com.ssk.best_beer_ranking/home');
    await _methodChannel.invokeMethod(
        'methodOfshowRequestTrackingAuthorization',
        "methodOfshowRequestTrackingAuthorization");
  }

  static void showAdFullscreenInterstitial() async {
    final MethodChannel _methodChannel =
        MethodChannel('com.ssk.best_beer_ranking/home');
    await _methodChannel.invokeMethod('methodOfshowAdFullscreenInterstitial',
        "methodOfshowAdFullscreenInterstitial");
  }
}
