import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_app_mari/constants.dart';
import 'package:fish_app_mari/screens/home/home_screen.dart';
import 'package:fish_app_mari/screens/login/login.dart';

import 'auth_service.dart';
import 'auth_provider.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
        auth: AuthService(),
        child: MaterialApp(
          title: 'Mari',
          theme: ThemeData(
            scaffoldBackgroundColor: kBackgroundColor,
            primaryColor: kPrimaryColor,
            textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: HomeController(),
        ));
  }
}

class HomeController extends StatelessWidget {
  const HomeController({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider
        .of(context)
        .auth;

    return StreamBuilder<User>(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<User> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn ? HomeScreen() : LoginPage();
        }
        return Container(
          color: Colors.black,
        );
      },
    );
  }
}
