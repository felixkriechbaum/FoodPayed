import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_payed/app/app.locator.dart';
import 'package:food_payed/models/entry.dart';
import 'package:food_payed/services/firebase_storage_service.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _storage = locator<FirebaseStorageService>();
  final _dialogService = locator<DialogService>();

  TextEditingController textController = TextEditingController();
  FocusNode focusNode = FocusNode();

  HomeViewModel() {
    _storage.onChange!.listen((event) {
      rebuildUi();
    });
  }

  Future<List<Entry>> fetchEntries() {
    return _storage.getEntries();
  }

  Future<bool> add() async {
    if (textController.text.isEmpty) return false;
    final entry = Entry(
      title: textController.text,
      date: DateFormat("dd.MMMM yyyy HH:mm", "de").format(DateTime.now()),
      firebaseId: FirebaseAuth.instance.currentUser!.uid,
    );

    bool result = await _storage.addEntry(entry);

    if (result) {
      focusNode.unfocus();
      textController.clear();
    }

    return result;
  }

  Future<bool> remove(String id) async {
    bool result = await _storage.removeEntry(id);
    return result;
  }

  Future<String> getUsername(String firebaseId) async {
    return await _storage.getUser(firebaseId);
  }

  Future showPayed(ctx) async {
    List<Entry> entries = await _storage.getEntries();
    await _storage.getAllUsers();
    List<(String, String)> namen = _storage.users;

    Map<String, int> namenZaehler = {};

    for (var name in entries) {
      String nm =
          namen.firstWhere((element) => element.$1 == name.firebaseId).$2;
      namenZaehler[nm] = (namenZaehler[nm] ?? 0) + 1;
    }

    String result = '';

    namenZaehler.forEach((name, anzahl) {
      result += '$name hat $anzahl mal gezahlt\n';
    });

    _dialogService.showDialog(
      title: "Zählung",
      description: result,
      buttonTitle: "Ok",
      barrierDismissible: true,
      dialogPlatform: DialogPlatform.Material,
    );
  }
}
