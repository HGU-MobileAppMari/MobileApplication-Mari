import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_app_mari/screens/generate_name/favorite_name_list_page.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Container(
              height: 50.0,
              padding: EdgeInsets.only(top: 50),
              child: Text(
                '${_firebaseAuth.currentUser.displayName},\n\nMENU',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text('Home'),
            leading: Icon(
              Icons.home,
              semanticLabel: 'home',
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('My favorite name'),
            leading: Icon(
              Icons.star,
              color: Colors.yellow[600],
              semanticLabel: 'My favorite name',
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyFavoritesPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
