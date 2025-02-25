import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_payed/app/app.locator.dart';
import 'package:food_payed/services/firebase_storage_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final _storage = locator<FirebaseStorageService>();
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential

    UserCredential userCred =
        await FirebaseAuth.instance.signInWithCredential(credential);

    if (userCred.user != null && userCred.user!.displayName != null) {
      _storage.addUser(userCred.user!.uid, userCred.user!.displayName!);

      return userCred;
    }

    throw Exception('Google Sign In failed');
  }

  Future<UserCredential> signInWithApple() async {
    final appleProvider = AppleAuthProvider();
    UserCredential userCred =
        await FirebaseAuth.instance.signInWithProvider(appleProvider);

    return userCred;
  }
}
