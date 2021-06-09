import 'package:fish_app_mari/constants.dart';
import 'package:flutter/material.dart';
import 'package:fish_app_mari/auth_service.dart';
import 'package:fish_app_mari/auth_provider.dart';
import 'package:fish_app_mari/components/my_appbar.dart';
import 'components/body.dart';
import 'components/unicorn_button.dart';
import 'package:fish_app_mari/screens/post_transaction/post_edit.dart';
import 'package:fish_app_mari/screens/post_transaction/post_delete.dart';
import 'package:fish_app_mari/screens/post_detail/components/unicorn_button.dart';
import 'package:fish_app_mari/model/post.dart';

@immutable
class PostDetailScreen extends StatelessWidget {
  final String _postId;
  final String _userId;

  PostDetailScreen({
    Key key,
    @required String postId,
    @required String userId,
  })  : _postId = postId,
        _userId = userId,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;

    print('post detail screen: $_postId');
    var childButtons = List<UnicornButton>();

    childButtons.add(
      UnicornButton(
        currentButton: FloatingActionButton(
          heroTag: "Edit Button",
          backgroundColor: kPrimaryColor,
          mini: true,
          child: Icon(Icons.edit),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostEditScreen(postId: _postId),
            ),
          ),
        ),
      ),
    );

    childButtons.add(
      UnicornButton(
        currentButton: FloatingActionButton(
          heroTag: "Delete Button",
          backgroundColor: kPrimaryColor,
          mini: true,
          child: Icon(Icons.delete),
          onPressed: () => showDeleteDialog(context, _postId),
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => showDeleteDialog(context, _postId),
          // ),
        ),
      ),
    );

    return Scaffold(
      appBar: MyAppbar(auth: auth),
      body: Body(
        postId: _postId,
      ),
      floatingActionButton: auth.firebaseAuth.currentUser.uid == _userId
          ? UnicornDialer(
              backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
              parentButtonBackground: kPrimaryColor,
              orientation: UnicornOrientation.VERTICAL,
              parentButton: Icon(Icons.edit),
              childButtons: childButtons)
          : null,
    );
  }
}
