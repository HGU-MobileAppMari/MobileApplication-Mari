import 'package:fish_app_mari/main.dart';
import 'package:flutter/material.dart';
import 'package:fish_app_mari/components/my_appbar.dart';
import 'package:fish_app_mari/screens/dictionary_detail/components/body.dart';

class DictionaryDetailScreen extends StatelessWidget {
  DictionaryDetailScreen({
    @required String name,
  }) : _name = name;
  final String _name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(),
      body: Body(name: _name),
    );
  }
}
