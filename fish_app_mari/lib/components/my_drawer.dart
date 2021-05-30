import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              padding: EdgeInsets.only(top: 100),
              child: Text(
                'MENU',
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
        ],
      ),
    );
  }
}
