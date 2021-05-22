import 'package:flutter/material.dart';

import 'package:fish_app_mari/screens/details/components/body.dart';
import 'package:fish_app_mari/components/my_bottom_nav_bar.dart';

class DictionaryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      drawer: buildDrawer(),
      body: Body(),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      elevation: 0,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.logout,
            semanticLabel: 'logout',
          ),
          // onPressed: () {
          //   signOut();
          //   Navigator.popUntil(context, ModalRoute.withName('/'));
          // },
        ),
      ],
    );
  }

  Drawer buildDrawer() {
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
            // onTap: () {
            //   Navigator.pop(context);
            // },
          ),
        ],
      ),
    );
  }
}
