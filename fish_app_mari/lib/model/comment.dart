import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String id;
  final String userId;
  final String writer;
  final String text;
  final Timestamp creationTime;
  final DocumentReference reference;

  Comment.fromSnapshot(DocumentSnapshot snapshot)
      : assert(snapshot != null),
        id = snapshot.id,
        userId = snapshot.data()['userId'],
        writer = snapshot.data()['writer'],
        text = snapshot.data()['text'],
        creationTime = snapshot.data()['creationTime'],
        reference = snapshot.reference;

  Comment.fromUserInput(
      {this.userId, this.writer, this.text, this.creationTime})
      : id = null,
        reference = null;
}
