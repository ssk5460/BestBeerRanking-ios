
import 'package:best_beer_ranking/data/model/user.dart';
import 'package:best_beer_ranking/data/provider/shared_preference_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userRepositoryProvider = Provider((ref) => UserRepositoryImpl(ref.read));

abstract class UserRepository {
  Future<User?> updateUser({required String id, String name, String description, String photoUrl});
  Future<User?> getUser(String firebaseAuthUserId);

  Future<List<User>> getWatchUsers();
  Future<void> watchUser(User user);
  Future<void> unWatchUser(User user);
}

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._reader);

  final Reader _reader;
  late final _sharedPreferencesManager = _reader(sharedPreferencesManagerProvider);


  @override
  Future<List<User>> getWatchUsers() async {
    final me = await _sharedPreferencesManager.getUser();
    if (me == null) {
      return [];
    }
    final collection = await FirebaseFirestore.instance.collection('user')
        .doc(me.id)
        .collection('watch')
        .get();
    final users = collection.docs.map((doc) => User.fromJson(doc.data())).toList();
    return users;
  }

  @override
  Future<void> watchUser(User user) async {
    final me = await _sharedPreferencesManager.getUser();
    if (me == null) {
      return;
    }
    return FirebaseFirestore.instance.collection('user')
        .doc('${me.id}')
        .collection('watch')
        .doc(user.id)
        .set(user.toJson());
  }

  @override
  Future<void> unWatchUser(User user) async {
    final me = await _sharedPreferencesManager.getUser();
    if (me == null) {
      return;
    }
    return FirebaseFirestore.instance.collection('user')
        .doc('${me.id}')
        .collection('watch')
        .doc(user.id)
        .delete();
  }

  @override
  Future<User?> updateUser({required String id, String name = "", String description = "", String photoUrl = ""}) async {
    await FirebaseFirestore.instance.collection('user')
        .doc('${id}')
        .set(User(
        id:  id,
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
