import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> addToFavorite(name) {
  String uid = FirebaseAuth.instance.currentUser.uid;
  FirebaseFirestore.instance.collection('name')
      .where('name', isEqualTo: name)
      .get().then(
          (querySnapshot) => {
        querySnapshot.docs.first.reference.update({'users' : FieldValue.arrayUnion([uid])})
      }
  );
}

Future<void> removeFromFavorite(name) {
  String uid = FirebaseAuth.instance.currentUser.uid;
  FirebaseFirestore.instance.collection('name')
      .where('name', isEqualTo: name)
      .get().then(
          (querySnapshot) => {
        querySnapshot.docs.first.reference.update({'users' : FieldValue.arrayRemove([uid])})
      }
  );
}