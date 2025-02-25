import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_payed/models/entry.dart';

class FirebaseStorageService {
  var db = FirebaseFirestore.instance;
  List<(String, String)> users = [];

  Future<bool> addUser(String id, String username) async {
    try {
      await db.collection('users').doc(id).set({'username': username});
      return true;
    } catch (e, s) {
      log('Error adding user: $e, $s');
      return false;
    }
  }

  Future<String> getUser(String id) async {
    try {
      if (users.any((element) => element.$1 == id)) {
        log("From cache");
        return users.firstWhere((element) => element.$1 == id).$2;
      }
      log("From db");
      var doc = await db.collection('users').doc(id).get();
      users.add((id, doc.data()!['username']));
      return doc.data()!['username'];
    } catch (e, s) {
      log('Error fetching user: $e, $s');
      return '';
    }
  }

  Future getAllUsers() async {
    try {
      users.clear();
      var snapshot = await db.collection('users').get();
      users.addAll(snapshot.docs
          .map((doc) => (doc.id, doc.data()['username'].toString()))
          .toList());
    } catch (e, s) {
      log('Error fetching users: $e, $s');
    }
  }

  Future<bool> addEntry(Entry entry) async {
    try {
      await db.collection('entries').add(entry.toJson());
      return true;
    } catch (e, s) {
      log('Error adding entry: $e, $s');
      return false;
    }
  }

  Future<List<Entry>> getEntries() async {
    try {
      var snapshot = await db.collection('entries').get();
      await getAllUsers();
      return snapshot.docs
          .map((doc) => Entry.fromJson(doc.data(), doc.id))
          .toList();
    } catch (e, s) {
      log('Error fetching entries: $e, $s');
      return [];
    }
  }

  Future<bool> removeEntry(String id) async {
    try {
      await db.collection('entries').doc(id).delete();
      return true;
    } catch (e, s) {
      log('Error removing entry: $e, $s');
      return false;
    }
  }
}
