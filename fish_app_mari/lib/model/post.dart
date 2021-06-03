import 'package:cloud_firestore/cloud_firestore.dart';

typedef PostPressedCallback = void Function(String postId, String userId);

class Post {
  final String id;
  final String userId;
  final String writer;
  final String title;
  final String description;
  final String imageURL;
  final Timestamp creationTime;
  final List<dynamic> likeUsers;
  final DocumentReference reference;

  Post(
      {this.userId,
      this.writer,
      this.title,
      this.description,
      this.imageURL,
      this.creationTime})
      : id = null,
        likeUsers = [],
        reference = null;

  Post.fromSnapshot(DocumentSnapshot snapshot)
      : assert(snapshot != null),
        id = snapshot.id,
        userId = snapshot.data()['userId'],
        writer = snapshot.data()['writer'],
        title = snapshot.data()['title'],
        description = snapshot.data()['description'],
        imageURL = snapshot.data()['imageURL'],
        creationTime = snapshot.data()['creationTime'],
        likeUsers = snapshot.data()['likeUsers'],
        reference = snapshot.reference;
}
