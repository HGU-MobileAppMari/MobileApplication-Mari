import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fish_app_mari/model/adopt_post.dart';
import 'comment.dart';
import 'dart:io';

Future<void> addComment({String postId, Comment comment}) {
  final adoptPost = FirebaseFirestore.instance.collection('adopt_post').doc(postId);
  final newComment = adoptPost.collection('comments').doc();
  return FirebaseFirestore.instance.runTransaction((Transaction transaction) {
    return transaction
        .get(adoptPost)
        .then((DocumentSnapshot doc) => AdoptPost.fromSnapshot(doc))
        .then((AdoptPost fresh) {
      transaction.set(newComment, {
        'userId': comment.userId,
        'writer': comment.writer,
        'text': comment.text,
        'created_at': comment.creationTime,
      });
    });
  });
}

Future<String> uploadImageToFireStorageGetURL(File imageFile, String imageName) async {
  Reference ref = FirebaseStorage.instance.ref().child('adopt_post').child(imageName);
  await ref.putFile(imageFile);
  var url = await ref.getDownloadURL();
  print("URL: " + url + "\n");
  return url;
}

Future<String> uploadImage(File image, String imageName) async {
  Reference ref = FirebaseStorage.instance.ref().child('adopt_post').child(imageName);
  UploadTask uploadTask = ref.putFile(image);
  TaskSnapshot snapshot = uploadTask.snapshot;
  String urlString = await snapshot.ref.getDownloadURL();
  return urlString;
}


Future<void> addAdoptPost(AdoptPost adopt) {
  final posts = FirebaseFirestore.instance.collection('adopt_post');
  return posts.add({
    'writer': adopt.writer,
    'writer_image': adopt.writerImage,
    'title': adopt.title,
    'fish_name' : adopt.fishName,
    'description': adopt.description,
    'image_url': adopt.postImageURL,
    'created_at': adopt.createdAt,
    'location': adopt.location
  });
}

Stream<QuerySnapshot> loadAllAdoptPosts() {
  return FirebaseFirestore.instance
      .collection('adopt_post')
      .orderBy('created_at', descending: true)
      .snapshots();
}


List<AdoptPost> getAdoptPostsFromQuery(QuerySnapshot snapshot) {
  return snapshot.docs.map((DocumentSnapshot doc) {
    return AdoptPost.fromSnapshot(doc);
  }).toList();
}

Future<AdoptPost> getAdoptPost(String postId) async {
  print('getPost: $postId');
  return FirebaseFirestore.instance
      .collection('adopt_post')
      .doc(postId)
      .get()
      .then((DocumentSnapshot doc) => AdoptPost.fromSnapshot(doc));
}