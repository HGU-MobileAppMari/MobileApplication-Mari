import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:provider/provider.dart';

import 'package:fish_app_mari/screens/home/home_screen.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 180.0),
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  '세상에서 가장 작은 아쿠아리움,',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  '마리',
                  style: TextStyle(
                    fontSize: 40.0,
                  ),
                ),
                Image.asset(
                  'assets/images/logo.png',
                  height: 130.0,
                  width: 140.0,
                ),
              ],
            ),
            Consumer<ApplicationState>(
              builder: (context, appState, _) {
                if (appState.loggedIn) {
                  print('logged in');
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ));
                  });
                } else {
                  print('logged out');
                }
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 5.0),
                      child: GoogleSignInButton(
                          centered: true,
                          onPressed: () {
                            appState.signInWithGoogle();
                          }),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ApplicationState extends ChangeNotifier {
  bool loggedIn = false;
  String username;

  ApplicationState() {
    init();
  }

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user == null) {
        loggedIn = false;
        //print('User is signed out!');
      } else {
        loggedIn = true;
        username = user.displayName;
        //print('User is signed in!');
      }
      notifyListeners();
    });
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    notifyListeners();

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
