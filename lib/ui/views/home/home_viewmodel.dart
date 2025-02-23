import 'package:food_payed/app/app.locator.dart';
import 'package:food_payed/services/firebase_auth_service.dart';
import 'package:food_payed/services/firebase_storage_service.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final _auth = locator<FirebaseAuthService>();
  final _storage = locator<FirebaseStorageService>();

  void add(String s) {}

  void remove(String s) {}
}
