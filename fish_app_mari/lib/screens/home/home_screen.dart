import 'package:flutter/material.dart';

import 'package:fish_app_mari/components/my_bottom_nav_bar.dart';
import 'package:fish_app_mari/components/my_appbar.dart';
import 'package:fish_app_mari/components/my_drawer.dart';
import 'package:fish_app_mari/screens/home/components/body.dart';
import 'package:fish_app_mari/auth_service.dart';
import 'package:fish_app_mari/auth_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;

    return Scaffold(
      appBar: MyAppbar(auth: auth),
      drawer: MyDrawer(),
      body: Body(),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}
