import 'package:flutter/material.dart';
import 'package:fish_app_mari/constants.dart';
import 'package:fish_app_mari/screens/post_add_or_edit/post_add.dart';

import 'posted_fish.dart';
import 'header.dart';
import 'title_with_more_bbtn.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // It will provie us total height  and width of our screen
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small device
    ScrollController _scrollController = new ScrollController(
      initialScrollOffset: 0.0,
      keepScrollOffset: true,
    );
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Header(size: size),
          TitleWithMoreBtn(
              title: "내 어항 자랑하기",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostAddScreen(),
                  ),
                );
              }),
          PostedFish(),
          SizedBox(height: kDefaultPadding),
        ],
      ),
    );
  }
}
