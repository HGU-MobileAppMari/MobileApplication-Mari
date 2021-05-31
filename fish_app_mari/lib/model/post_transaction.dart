import 'package:cloud_firestore/cloud_firestore.dart';

import 'post.dart';
import 'comment.dart';

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

Future<Post> getPost(String postId) async {
  print('getPost: $postId');
  return FirebaseFirestore.instance
      .collection('posts')
      .doc(postId)
      .get()
      .then((DocumentSnapshot doc) => Post.fromSnapshot(doc));
}

Future<void> addComment({String postId, Comment comment}) {
  final post = FirebaseFirestore.instance.collection('posts').doc(postId);
  final newComment = post.collection('comments').doc();

  return FirebaseFirestore.instance.runTransaction((Transaction transaction) {
    return transaction
        .get(post)
        .then((DocumentSnapshot doc) => Post.fromSnapshot(doc))
        .then((Post fresh) {
      //give # of comment ?
      /*transaction.update(post, {
      })*/
      transaction.set(newComment, {
        'userId': comment.userId,
        'writer': comment.writer,
        'text': comment.text,
        'creationTime': comment.creationTime,
      });
    });
  });
}
