import 'dart:convert';

import 'package:best_beer_ranking/data/foundation/keys.dart';
import 'package:best_beer_ranking/data/model/category.dart';
import 'package:best_beer_ranking/data/model/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final prefsProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final sharedPreferencesManagerProvider = Provider((ref) => SharedPreferencesManager(ref.read));

class SharedPreferencesManager {
  SharedPreferencesManager(this._reader);
  final Reader _reader;

  late final _pref = _reader(prefsProvider);

  Future<void> setCategory(Category category) async {
    await _pref.setString(Keys.defaultCategpory, jsonEncode(category));
  }

  Future<Category?> getCategory() async {
    final json = _pref.getString(Keys.defaultCategpory);
    if (json == null) {
      return null;
    }
    Map<String, dynamic> map = await jsonDecode(json);
    return Category.fromJson(map);
  }

  Future<void> setUser(User user) async {
    await _pref.setString(Keys.user, jsonEncode(user));
  }

  Future<User?> getUser() async {
    final json = _pref.getString(Keys.user);
    if (json == null) {
      return null;
    }
    Map<String, dynamic> map = await jsonDecode(json);
    return User.fromJson(map);
  }
}