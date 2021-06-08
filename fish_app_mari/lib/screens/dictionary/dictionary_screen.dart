import 'package:flutter/material.dart';
import 'components/body.dart';

class DictionaryScreen extends StatelessWidget {
  DictionaryScreen({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
