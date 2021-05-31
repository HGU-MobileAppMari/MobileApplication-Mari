import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fish_app_mari/components/my_bottom_nav_bar.dart';
import 'package:fish_app_mari/screens/home/components/body.dart';
import 'package:fish_app_mari/screens/adopt/adopt_page.dart';
import 'package:fish_app_mari/screens/generate_name/name.dart';
import 'package:fish_app_mari/constants.dart';
import 'package:fish_app_mari/auth_service.dart';
import 'package:fish_app_mari/auth_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    List _widgetOptions = [
      Body(),
      Text(
        'Music',
        style: TextStyle(fontSize: 30, fontFamily: 'DoHyeonRegular'),
      ),
      AdoptPage(),
      Text(
        'News',
        style: TextStyle(fontSize: 30, fontFamily: 'DoHyeonRegular'),
      ),
      NamePage(),
    ];

    return Scaffold (
      appBar: buildAppBar(auth),
      drawer: buildDrawer(),
      // body: Body(),
      // bottomNavigationBar: MyBottomNavBar(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: kTextColor,
        unselectedItemColor: kTextColor.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        currentIndex: _selectedIndex, //현재 선택된 Index
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
            print(_selectedIndex.toString() + " ");
          });
        },
        items: [
          BottomNavigationBarItem(
            label: "어항 자랑",
            icon: Icon(Icons.home_outlined),
          ),
          BottomNavigationBarItem(
            label: "사전",
            icon: Icon(Icons.menu_book_outlined),
          ),
          BottomNavigationBarItem(
            label: "분양",
            icon: Icon(Icons.shopping_cart_outlined),
          ),
          BottomNavigationBarItem(
            label: "가게",
            icon: Icon(Icons.location_on_outlined),
          ),
          BottomNavigationBarItem(
            label: "이름짓기",
            icon: Icon(Icons.set_meal_outlined),
          ),
      ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }

  AppBar buildAppBar(AuthService auth) {
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
            auth.signOut();
          },
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
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
