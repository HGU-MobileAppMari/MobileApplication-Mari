import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'post.dart';
import 'comment.dart';

Future<void> addPost(Post post) {
  final posts = FirebaseFirestore.instance.collection('posts');
  return posts.add({
    'userId': post.userId,
    'writer': post.writer,
    'title': post.title,
    'description': post.description,
    'imageURL': post.imageURL,
    'creationTime': post.creationTime,
    'likeUsers': post.likeUsers,
  });
}

Future<void> editPost(
    String postId, String title, String description, String imageURL) {
  final firebase_post =
      FirebaseFirestore.instance.collection('posts').doc(postId);
  return firebase_post.update({
    'title': title,
    'description': description,
    'imageURL': imageURL,
  });
}

Future<void> deletePost(String postId) async {
  final firebase_post =
      FirebaseFirestore.instance.collection('posts').doc(postId);
  final storage_post = FirebaseStorage.instance;
  String postCreationTime;
  String postUserId;
  String imageName;
  firebase_post.get().then((value) {
    postCreationTime = value.data()['creationTime'].toString();
    postUserId = value.data()['userId'];
    imageName = postCreationTime + "_" + postUserId;
    storage_post
        .ref("/posts/" + imageName)
        .delete()
        .then((value) => firebase_post.delete());
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
      transaction.set(newComment, {
        'userId': comment.userId,
        'writer': comment.writer,
        'text': comment.text,
        'creationTime': comment.creationTime,
      });
    });
  });
}
