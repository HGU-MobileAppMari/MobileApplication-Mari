import 'package:flutter/material.dart';
import 'package:fish_app_mari/model/adopt_post.dart';
import 'package:fish_app_mari/screens/adopt/fish_adopt_card.dart';

class FishGrid extends StatelessWidget {
  FishGrid({
    @required List<AdoptPost> posts,
    @required PostPressedCallback onPostPressed,
  })  : _posts = posts,
        _onPostPressed = onPostPressed;

  final List<AdoptPost> _posts;
  final PostPressedCallback _onPostPressed;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: _posts
            .map(
              (post) => AdoptCard(
                adoptPost: post,
                onPostPressed: _onPostPressed,
              ),
            )
            .toList(),
      ),
    );
  }
}
