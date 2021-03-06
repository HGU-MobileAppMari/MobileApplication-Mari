import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_app_mari/model/adopt_post_transaction.dart';
import 'package:fish_app_mari/model/adopt_post.dart';
import 'package:fish_app_mari/model/comment.dart';
import '../../constants.dart';

class ImageAndText extends StatefulWidget {
  const ImageAndText({
    Key key,
    @required String postId,
  })  : _postId = postId,
        super(key: key);

  final String _postId;

  @override
  _ImageAndTextState createState() => _ImageAndTextState(postId: _postId);
}

class _ImageAndTextState extends State<ImageAndText> {
  bool _isLoading = true;
  StreamSubscription<QuerySnapshot> _currentCommentSubscription;
  AdoptPost _post;
  String _userId;
  List<Comment> _comments = <Comment>[];
  int likeNum;
  int commentsNum;

  final _formKey = GlobalKey<FormState>(debugLabel: '_ImageAndTextState');
  final _commentController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  _ImageAndTextState({@required String postId}) {
    getAdoptPost(postId).then((AdoptPost post) {
      _currentCommentSubscription?.cancel();
      setState(() {
        _post = post;
        _userId = _firebaseAuth.currentUser.uid;
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

  @override
  void dispose() {
    _currentCommentSubscription?.cancel();
    super.dispose();
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
                DateFormat('yyyy??? MM??? dd??? kk???mm???')
                    .format(_post.createdAt.toDate()),
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 10.0,
                left: 30.0,
                right: 25.0,
              ),
              child: Text(
                '????????????: ${_post.location}',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            buildDivider(),
            Container(
              padding: EdgeInsets.only(
                top: 20.0,
                left: 25.0,
                right: 25.0,
              ),
              child: Image.network(
                _post.postImageURL,
                //fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 20.0,
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
                          hintText: '????????? ???????????????',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '??????????????? ????????? ???????????????';
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
                      child: Text('??????'),
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
                        '${DateFormat('yyyy??? MM??? dd???').format(comment.creationTime.toDate())}\n${DateFormat('kk???mm???').format(comment.creationTime.toDate())}',
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
