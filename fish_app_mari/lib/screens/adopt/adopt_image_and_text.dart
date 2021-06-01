import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_app_mari/model/adopt_post_transaction.dart';
import 'package:fish_app_mari/model/adopt_post.dart';
import 'package:fish_app_mari/constants.dart';

class ImageAndText extends StatefulWidget {
  final String postId;
  const ImageAndText({@required this.postId});
  @override
  _ImageAndTextState createState() => _ImageAndTextState();
}

class _ImageAndTextState extends State<ImageAndText> {
  bool isOkay = false;
  AdoptPost _post;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<AdoptPost> callAsyncAdoptPost() async {
      return getAdoptPost(widget.postId);
  }

  @override
  Widget build(context) {
    return Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<AdoptPost>(
                  future: callAsyncAdoptPost(),
                  builder: (context, AsyncSnapshot<AdoptPost> snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        child: Image.network(snapshot.data.postImageURL, fit: BoxFit.fitWidth),
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                      );
                      //return Image.network(snapshot.data.postImageURL);
                    }
                    else {
                      return CircularProgressIndicator();
                    }
                  }
              ),
            ],
          ),
        )
    );
  }
}