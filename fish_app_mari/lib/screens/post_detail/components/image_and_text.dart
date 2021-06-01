import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:fish_app_mari/model/post_transaction.dart';
import 'package:fish_app_mari/model/post.dart';
import 'package:fish_app_mari/model/comment.dart';

import '../../../constants.dart';

class ImageAndText extends StatefulWidget {
  const ImageAndText({
    Key key,
    //@required this.size,
    @required String postId,
  })  : _postId = postId,
        super(key: key);

  //final Size size;
  final String _postId;

  @override
  _ImageAndTextState createState() => _ImageAndTextState(postId: _postId);
}

class _ImageAndTextState extends State<ImageAndText> {
  bool _isLoading = true;
  StreamSubscription<QuerySnapshot> _currentCommentSubscription;
  Post _post;
  String _userId;
  List<Comment> _comments = <Comment>[];

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  _ImageAndTextState({@required String postId}) {
    getPost(postId).then((Post post) {
      _currentCommentSubscription?.cancel();
      setState(() {
        _post = post;
        _userId = _firebaseAuth.currentUser.uid;
        _currentCommentSubscription = _post.reference
            .collection('comments')
            .orderBy('creationTime', descending: true)
            .snapshots()
            .listen((QuerySnapshot commentSnap) {
          setState(() {
            _isLoading = false;
            _comments = commentSnap.docs.map((DocumentSnapshot doc) {
              return Comment.fromSnapshot(doc);
            }).toList();
          });
        });
      });
    });
  }

  @override
  void dispose() {
    _currentCommentSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.only(bottom: kDefaultPadding * 3),
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      top: 30.0,
                      left: 30.0,
                    ),
                    child: Text(
                      _post.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(
                    height: 10.0,
                    indent: 20.0,
                    endIndent: 20.0,
                    color: Colors.black,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(63),
                        bottomLeft: Radius.circular(63),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 60,
                          color: kPrimaryColor.withOpacity(0.29),
                        ),
                      ],
                      image: DecorationImage(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.cover,
                        image: FileImage(File(_post.imageURL)),
                      ),
                    ),
                  ),
                  
                ],
              ),
            ),
          );
  }
}
