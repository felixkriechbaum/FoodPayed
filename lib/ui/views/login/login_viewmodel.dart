import 'package:food_payed/app/app.locator.dart';
import 'package:food_payed/services/firebase_auth_service.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends BaseViewModel {
  final _auth = locator<FirebaseAuthService>();

  void loginWithGoogle() async {
    await _auth.signInWithGoogle();
  }

  void loginWithApple() {}
}
