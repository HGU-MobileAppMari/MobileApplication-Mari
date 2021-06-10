import 'package:flutter/material.dart';
import 'package:fish_app_mari/constants.dart';

import 'image_and_icons.dart';

class Body extends StatelessWidget {
  Body({
    @required String name,
  }) : _name = name;
  final String _name;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ImageAndIcons(size: size, name: _name),
          SizedBox(height: kDefaultPadding),
        ],
      ),
    );
  }
}
