import 'dart:async';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:fish_app_mari/model/post_transaction.dart';
import 'package:fish_app_mari/model/post.dart';
import 'package:fish_app_mari/model/comment.dart';

import '../../../constants.dart';

class PostComment extends StatefulWidget {
  const PostComment({
    Key key,
    //@required this.size,
    @required String postId,
  })  : _postId = postId,
        super(key: key);

  //final Size size;
  final String _postId;

  @override
  _PostComment createState() => _PostComment(postId: _postId);
}

class _PostComment extends State<PostComment> {
  bool _isLoading = true;
  StreamSubscription<QuerySnapshot> _currentCommentSubscription;
  Post _post;
  String _userId;
  List<Comment> _comments = <Comment>[];

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  _PostComment({@required String postId}) {
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
                    indent: 20.0,
                    endIndent: 20.0,
                    color: kPrimaryColor,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: 30.0,
                    ),
                    child: Text(
                      _post.writer,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: 30.0,
                    ),
                    child: Text(
                      '${DateFormat('yyyy년 MM월 dd일 kk시mm분').format(_post.creationTime.toDate())}',
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 30.0,
                      left: 20.0,
                      right: 20.0,
                    ),
                    child: Image.network(
                      _post.imageURL,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 30.0,
                      left: 30.0,
                    ),
                    child: Text(
                      '${_post.description}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
