
import 'dart:convert';
import 'dart:io';

import 'package:best_beer_ranking/data/local/record_database.dart';
import 'package:best_beer_ranking/data/model/category.dart';
import 'package:best_beer_ranking/data/model/ranking.dart';
import 'package:best_beer_ranking/data/model/record.dart';
import 'package:best_beer_ranking/data/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final rankingRepositoryProvider = Provider((ref) => RankingRepositoryImpl(ref.read));

abstract class RankingRepository {
  Future<void> postRanking(User user, Category category, List<Record> records);
  Future<List<Ranking>> getRankings();

  Future<List<Ranking>> getWatchUserRankings(List<User> users);
}

class RankingRepositoryImpl implements RankingRepository {
  RankingRepositoryImpl(this._reader);

  final Reader _reader;

  late final RecordDatabase _recordDatabase = _reader(recordDatabaseProvider);

  @override
  Future<void> postRanking(User user, Category category, List<Record> records) {
    final auth = firebase_auth.FirebaseAuth.instance.currentUser;
    return FirebaseFirestore.instance.collection('ranking')
        .doc('${auth?.uid}:${category.id}')
        .set({
      "user":user.toJson(),
      "userId":user.id,
      "category":category.toJson(),
      "records":records.map((e) => e.toJson()).toList(),
      "updatedAt":DateTime.now().millisecondsSinceEpoch });
  }

  @override
  Future<List<Ranking>> getRankings() async {
    final querySnapshot = await FirebaseFirestore.instance.collection('ranking')
        .orderBy('updatedAt', descending: true)
        .get();
    final rankings = querySnapshot.docs.map((doc) => Ranking.fromJson(doc.data())).toList();
    return rankings;
  }

  @override
  Future<List<Ranking>> getWatchUserRankings(List<User> users) async {
    final userIds = users.map((e) => e.id).toList();
    final querySnapshot = await FirebaseFirestore.instance.collection('ranking')
        .orderBy('updatedAt', descending: true)
        .where('userId', whereIn: userIds)
        .get();
    final rankings = querySnapshot.docs.map((doc) => Ranking.fromJson(doc.data())).toList();
    return rankings;
  }

}
