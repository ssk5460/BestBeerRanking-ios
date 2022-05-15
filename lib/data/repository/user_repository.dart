
import 'package:best_beer_ranking/data/local/record_database.dart';
import 'package:best_beer_ranking/data/model/category.dart';
import 'package:best_beer_ranking/data/model/ranking.dart';
import 'package:best_beer_ranking/data/model/record.dart';
import 'package:best_beer_ranking/data/model/user.dart';
import 'package:best_beer_ranking/data/provider/shared_preference_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userRepositoryProvider = Provider((ref) => UserRepositoryImpl(ref.read));

abstract class UserRepository {
  Future<User?> updateUser({required String id, String name, String description, String photoUrl});
  Future<User?> getUser(String firebaseAuthUserId);
}

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._reader);

  final Reader _reader;
  late final _sharedPreferencesManager = _reader(sharedPreferencesManagerProvider);



  @override
  Future<User?> updateUser({required String id, String name = "", String description = "", String photoUrl = ""}) async {
    await FirebaseFirestore.instance.collection('user')
        .doc('${id}')
        .set(User(
        name: name,
        photoUrl: photoUrl,
        description: description)
        .toJson()
    );
    final user = await getUser(id);
    return user;
  }

  @override
  Future<User?> getUser(String firebaseAuthUserId) async {
    final doc = await FirebaseFirestore.instance.collection('user').doc(firebaseAuthUserId).get();
    final data = doc.data();
    if (data?.isNotEmpty == true) {
      final user = User.fromJson(doc.data()!);
      await _sharedPreferencesManager.setUser(user);
      return user;
    }
    return null;
  }
}
