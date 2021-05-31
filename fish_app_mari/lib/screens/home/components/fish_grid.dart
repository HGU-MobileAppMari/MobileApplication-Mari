import 'package:flutter/material.dart';

import 'package:fish_app_mari/model/post.dart';
import 'fish_card.dart';

class FishGrid extends StatelessWidget {
  FishGrid({
    @required List<Post> posts,
    @required PostPressedCallback onPostPressed,
  })  : _posts = posts,
        _onPostPressed = onPostPressed;

  final List<Post> _posts;
  final PostPressedCallback _onPostPressed;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: _posts
            .map(
              (post) => FishCard(
                post: post,
                onPostPressed: _onPostPressed,
              ),
            )
            .toList(),
      ),
    );
  }
}
