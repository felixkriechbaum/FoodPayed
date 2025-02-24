import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_payed/models/entry.dart';

class FirebaseStorageService {
  Future<bool> addEntry(Entry entry) async {
    try {
      var db = FirebaseFirestore.instance;
      await db.collection('entries').add(entry.toJson());
      return true;
    } catch (e, s) {
      log('Error adding entry: $e, $s');
      return false;
    }
  }

  Future<List<Entry>> getEntries() async {
    try {
      var db = FirebaseFirestore.instance;
      var snapshot = await db.collection('entries').get();
      return snapshot.docs.map((doc) => Entry.fromJson(doc.data())).toList();
    } catch (e, s) {
      log('Error fetching entries: $e, $s');
      return [];
    }
  }

  Future<bool> removeEntry(String id) async {
    try {
      var db = FirebaseFirestore.instance;
      await db.collection('entries').doc(id).delete();
      return true;
    } catch (e, s) {
      log('Error removing entry: $e, $s');
      return false;
    }
  }
}
