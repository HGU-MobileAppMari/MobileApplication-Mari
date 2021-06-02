import 'package:flutter/material.dart';

import 'package:fish_app_mari/auth_service.dart';
import 'package:fish_app_mari/auth_provider.dart';
import 'package:fish_app_mari/components/my_appbar.dart';
import 'components/body.dart';
import 'components/post_fab.dart';
import 'package:fish_app_mari/screens/post_add_or_edit/post_edit.dart';

@immutable
class PostDetailScreen extends StatelessWidget {
  final String _postId;

  PostDetailScreen({
    Key key,
    @required String postId,
  })  : _postId = postId,
        super(key: key);

  static const _actionTitles = ['Edit Post', 'Delete Post', 'random'];

  void _showAction(BuildContext context, int index) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(_actionTitles[index]),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;

    print('post detail screen: $_postId');
    return Scaffold(
      appBar: MyAppbar(auth: auth),
      body: Body(
        postId: _postId,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostEditScreen(postId: _postId),
          ),
        ),
      ),
    );
  }
}
