import 'package:flutter/material.dart';

import 'package:fish_app_mari/screens/home/components/title_with_more_bbtn.dart'
    as title;
import 'package:fish_app_mari/constants.dart';
import 'package:fish_app_mari/screens/dictionary_detail/dictionary_detail.dart';

class Body extends StatefulWidget {
  Body({
    Key key,
  }) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController _searchController = new TextEditingController();
  List<String> _list;
  String _searchText = "";

  _BodyState() {
    _searchController.addListener(() {
      if (_searchController.text.isEmpty) {
        setState(() {
          _searchText = "";
        });
      } else {
        setState(() {
          _searchText = _searchController.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    _list = List();
    _list.add("구피");
    _list.add("금붕어");
    _list.add("나비고기");
    _list.add("남양쥐돔");
    _list.add("니그로");
    _list.add("디스커스");
    _list.add("베타");
    _list.add("엔젤피쉬");
    _list.add("키싱구라미");
    _list.add("흰동가리");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20.0),
          child: title.TitleWithCustomUnderline(
            text: "물고기 사전",
          ),
        ),
        Container(
          padding: EdgeInsets.all(20.0),
          child: buildSearchBox(context),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            children: _buildSearchList(),
          ),
        ),
      ],
    );
  }

  List<ChildItem> _buildSearchList() {
    if (_searchText.isEmpty) {
      return _list.map((contact) => ChildItem(contact)).toList();
    } else {
      List<String> _searchList = List();
      for (int i = 0; i < _list.length; i++) {
        String name = _list.elementAt(i);
        if (name.toLowerCase().contains(_searchText.toLowerCase())) {
          _searchList.add(name);
        }
      }
      return _searchList.map((contact) => ChildItem(contact)).toList();
    }
  }

  Widget buildSearchBox(BuildContext context) {
    return TextField(
      controller: _searchController,
      style: TextStyle(
        color: Colors.black,
      ),
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: Colors.black),
          hintText: "Search...",
          hintStyle: TextStyle(color: Colors.black)),
    );
  }
}

class ChildItem extends StatelessWidget {
  final String name;
  ChildItem(this.name);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(this.name),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DictionaryDetailScreen(name: this.name),
        ),
      ),
    );
  }
}
