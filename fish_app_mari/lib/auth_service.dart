import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<User> get onAuthStateChanged => _firebaseAuth.authStateChanges();
  FirebaseAuth get firebaseAuth => _firebaseAuth;

  /* Google */
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      print('Google Signin ERROR! googleUser: null!');
      return null;
    }
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await _googleSignIn.signOut();
  }
}

// https://stackoverflow.com/questions/64520543/struggling-with-authstatechanges-in-flutter
