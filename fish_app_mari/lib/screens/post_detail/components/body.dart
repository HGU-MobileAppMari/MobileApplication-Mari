import 'package:flutter/material.dart';
import 'package:fish_app_mari/constants.dart';

import 'image_and_text.dart';

class Body extends StatelessWidget {
  final String _postId;

  Body({
    @required String postId,
  }) : _postId = postId;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ImageAndText(postId: _postId),
          SizedBox(height: kDefaultPadding),
        ],
      ),
    );
  }
}
