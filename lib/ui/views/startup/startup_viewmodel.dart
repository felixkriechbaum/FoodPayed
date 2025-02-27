import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_payed/app/app.locator.dart';
import 'package:food_payed/app/app.router.dart';
import 'package:food_payed/services/firebase_storage_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _storage = locator<FirebaseStorageService>();

  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      log("Firebase Auth Changed");
      if (user == null) {
        _navigationService.replaceWithLoginView();
      } else {
        _storage.init();
        _navigationService.replaceWithHomeView();
      }
    });
  }
}
