import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:fish_app_mari/auth_service.dart';
import 'package:fish_app_mari/auth_provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
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
                Container(
                  padding: EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 5.0),
                  child: GoogleSignInButton(
                      centered: true,
                      onPressed: () {
                        auth.signInWithGoogle();
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
