import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:food_payed/app/app.locator.dart';
import 'package:food_payed/models/entry.dart';
import 'package:food_payed/services/firebase_auth_service.dart';
import 'package:food_payed/services/firebase_storage_service.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final _auth = locator<FirebaseAuthService>();
  final _storage = locator<FirebaseStorageService>();

  TextEditingController textController = TextEditingController();

  Future<List<Entry>> fetchEntries() {
    return _storage.getEntries();
  }

  Future<bool> add(String id) async {
    if (textController.text.isEmpty) return false;
    final entry = Entry(
      id: id,
      title: textController.text,
      date: DateTime.now(),
      firebaseId: FirebaseAuth.instance.currentUser!.uid,
    );

    bool result = await _storage.addEntry(entry);

    if (result) {
      textController.clear();
      fetchEntries();
    }

    return result;
  }

  Future<bool> remove(String id) async {
    bool result = await _storage.removeEntry(id);
    if (result) fetchEntries();
    return result;
  }
}
