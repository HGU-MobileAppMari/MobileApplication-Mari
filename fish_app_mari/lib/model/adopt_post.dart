import 'package:cloud_firestore/cloud_firestore.dart';

typedef PostPressedCallback = void Function(String postId);

class AdoptPost {
  final String id;
  final String writer;
  final String writerImage;
  final String title;
  final String fishName;
  final String postImageURL;
  final String description;
  final Timestamp createdAt;
  final String location; // 전국, 서울, 경기, ... , default = null (전국)
  final DocumentReference reference;

  AdoptPost({
    this.writerImage,
    this.writer,
    this.title,
    this.fishName,
    this.postImageURL,
    this.description,
    this.createdAt,
    this.location})
      : id = null,
        reference = null;

  AdoptPost.fromSnapshot(DocumentSnapshot snapshot)
      : assert(snapshot != null),
        id = snapshot.id,
        reference = snapshot.reference,
        writer = snapshot.data()['writer'],
        writerImage = snapshot.data()['writer_image'],
        fishName = snapshot.data()['fish_name'],
        title = snapshot.data()['title'],
        description = snapshot.data()['description'],
        postImageURL = snapshot.data()['image_url'],
        createdAt = snapshot.data()['created_at'],
        location = snapshot.data()['location'];
}