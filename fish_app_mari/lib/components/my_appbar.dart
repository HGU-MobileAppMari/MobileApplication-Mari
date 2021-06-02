import 'package:flutter/material.dart';
import 'package:fish_app_mari/auth_service.dart';

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  MyAppbar({
    AuthService auth,
  }) : _auth = auth;

  final AuthService _auth;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      elevation: 0,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.logout,
            semanticLabel: 'logout',
          ),
          onPressed: () {
            _auth.signOut();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}
