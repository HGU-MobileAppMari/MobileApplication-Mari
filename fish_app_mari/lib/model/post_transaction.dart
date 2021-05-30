import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import './post.dart';

Future<void> addPost(Post post) {
  final posts = FirebaseFirestore.instance.collection('posts');
  return posts.add({
    'writer': post.writer,
    'title': post.title,
    'description': post.description,
    'imageURL': post.imageURL,
    'creationTime': post.creationTime,
    'likeUsers': post.likeUsers,
  });
}

Stream<QuerySnapshot> loadAllPosts() {
  return FirebaseFirestore.instance
      .collection('posts')
      .orderBy('creationTime', descending: true)
      .snapshots();
}

List<Post> getPostsFromQuery(QuerySnapshot snapshot) {
  return snapshot.docs.map((DocumentSnapshot doc) {
    return Post.fromSnapshot(doc);
  }).toList();
}

Future<Post> getPost(String postId) {
  return FirebaseFirestore.instance
      .collection('posts')
      .doc(postId)
      .get()
      .then((DocumentSnapshot doc) => Post.fromSnapshot(doc));
}
