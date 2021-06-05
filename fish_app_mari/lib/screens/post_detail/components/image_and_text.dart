import 'dart:async';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:fish_app_mari/model/post_transaction.dart';
import 'package:fish_app_mari/model/post.dart';
import 'package:fish_app_mari/model/comment.dart';
import 'package:fish_app_mari/screens/post_transaction/post_edit.dart';

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
  List<dynamic> _postLikers = <dynamic>[];
  int likeNum;
  int commentsNum;

  final _formKey = GlobalKey<FormState>(debugLabel: '_ImageAndTextState');
  final _commentController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  _ImageAndTextState({@required String postId}) {
    getPost(postId).then((Post post) {
      _currentCommentSubscription?.cancel();
      setState(() {
        _post = post;
        _userId = _firebaseAuth.currentUser.uid;
        _postLikers = _post.likeUsers;
        likeNum = _postLikers.length;
        _currentCommentSubscription = _post.reference
            .collection('comments')
            .orderBy('creationTime')
            .snapshots()
            .listen((QuerySnapshot commentSnap) {
          setState(() {
            _isLoading = false;
            _comments = commentSnap.docs.map((DocumentSnapshot doc) {
              return Comment.fromSnapshot(doc);
            }).toList();
            commentsNum = _comments.length;
          });
        });
      });
    });
  }
  void getData() {
    getPost(widget._postId).then((Post post) {
      setState(() {
        _post = post;
      });
    });
  }

  @override
  void dispose() {
    _currentCommentSubscription?.cancel();
    super.dispose();
  }

  // FutureOr onGoBack(dynamic value) {
  //   getData();
  //   setState(() {});
  // }

  Future<void> pushLike(String postId, List<dynamic> likeUsers) {
    FirebaseFirestore.instance.collection('posts').doc(postId).update({
      'likeUsers': likeUsers,
    });
    setState(() {
      _postLikers = likeUsers;
      likeNum = _postLikers.length;
    });
  }

  Divider buildDivider() {
    return Divider(
      indent: 20.0,
      endIndent: 20.0,
      color: kPrimaryColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    getData();
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
                  Container(
                    padding: EdgeInsets.only(
                      top: 10.0,
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
                      DateFormat('yyyy년 MM월 dd일 kk시mm분')
                          .format(_post.creationTime.toDate()),
                    ),
                  ),
                  buildDivider(),
                  Container(
                    padding: EdgeInsets.only(
                      top: 30.0,
                      left: 25.0,
                      right: 25.0,
                    ),
                    child: Image.network(
                      _post.imageURL,
                      //fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 30.0,
                      left: 25.0,
                      right: 25.0,
                    ),
                    child: Text(
                      '${_post.description}',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton.icon(
                        icon: Icon(
                            _postLikers.contains(_userId)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: kPrimaryColor),
                        onPressed: () async {
                          if (!_postLikers.contains(_userId)) {
                            _postLikers.add(_userId);
                            pushLike(_post.id, _postLikers);
                          } else {
                            _postLikers.remove(_userId);
                            pushLike(_post.id, _postLikers);
                          }
                        },
                        label: Text('$likeNum'),
                      ),
                      TextButton.icon(
                        icon: Icon(Icons.comment, color: kPrimaryColor),
                        label: Text('$commentsNum'),
                      ),
                    ],
                  ),
                  buildDivider(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _commentController,
                              decoration: const InputDecoration(
                                hintText: '덧글을 입력하세요',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '계속하려면 덧글을 입력하세요';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(width: 8),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                side: BorderSide(color: kPrimaryColor)),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                await addComment(
                                  postId: _post.id,
                                  comment: Comment.fromUserInput(
                                    userId: _userId,
                                    writer:
                                        _firebaseAuth.currentUser.displayName,
                                    text: _commentController.text,
                                    creationTime: Timestamp.now(),
                                  ),
                                );
                                _commentController.clear();
                              }
                            },
                            child: Text('작성'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  for (var comment in _comments)
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5.0,
                        bottom: 5.0,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20.0,
                                  ),
                                  child: Text(
                                    comment.writer,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20.0,
                                  ),
                                  child: Text(
                                    comment.text,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 10.0),
                            child: Text(
                              '${DateFormat('yyyy년 MM월 dd일').format(comment.creationTime.toDate())}\n${DateFormat('kk시mm분').format(comment.creationTime.toDate())}',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                          )
                        ],
                      ),
                    ),
                ],
              ),
            ),
          );
  }
}
