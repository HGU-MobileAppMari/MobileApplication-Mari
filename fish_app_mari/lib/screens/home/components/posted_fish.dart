import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fish_app_mari/model/post_transaction.dart';
import 'package:fish_app_mari/model/post.dart';
import 'fish_grid.dart';
import 'package:fish_app_mari/screens/post_detail/post_detail.dart';

class PostedFish extends StatefulWidget {
  @override
  _PostedFishState createState() => _PostedFishState();
}

class _PostedFishState extends State<PostedFish> {
  StreamSubscription<QuerySnapshot> _currentSubscription;
  List<Post> _posts = <Post>[];

  _PostedFishState() {
    _currentSubscription = loadAllPosts().listen(_updatePosts);
  }

  @override
  void dispose() {
    _currentSubscription?.cancel();
    super.dispose();
  }

  void _updatePosts(QuerySnapshot snapshot) {
    setState(() {
      _posts = getPostsFromQuery(snapshot);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FishGrid(
      posts: _posts,
      onPostPressed: (id, userId) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostDetailScreen(postId: id, userId: userId),
          ),
        );
      },
    );
  }
}
