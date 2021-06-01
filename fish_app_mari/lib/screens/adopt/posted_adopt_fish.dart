import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_app_mari/model/adopt_post.dart';
import 'package:fish_app_mari/model/adopt_post_transaction.dart';
import 'fish_adopt_grid.dart';
import 'package:fish_app_mari/screens/post_detail/post_detail.dart';

class PostedFish extends StatefulWidget {
  @override
  _PostedFishState createState() => _PostedFishState();
}

class _PostedFishState extends State<PostedFish> {
  StreamSubscription<QuerySnapshot> _currentSubscription;
  List<AdoptPost> _posts = <AdoptPost>[];

  _PostedFishState() {
    _currentSubscription = loadAllAdoptPosts().listen(_updatePosts);
  }

  @override
  void dispose() {
    _currentSubscription?.cancel();
    super.dispose();
  }

  void _updatePosts(QuerySnapshot snapshot) {
    setState(() {
      _posts = getAdoptPostsFromQuery(snapshot);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FishGrid(
      posts: _posts,
      onPostPressed: (id) {
        Navigator.push(
          context,
          MaterialPageRoute(
            // builder: (context) => PostDetailScreen(postId: id),
            builder: (context) => null,
          ),
        );
      },
    );
  }
}
