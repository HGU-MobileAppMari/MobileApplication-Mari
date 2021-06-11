import 'package:flutter/material.dart';

import 'package:fish_app_mari/model/post_transaction.dart';
import 'package:fish_app_mari/screens/home/home_screen.dart';

Future<void> showDeleteDialog(BuildContext context, String _postId) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text("삭제?"),
      content: Text("정말로 삭제하시겠습니까?"),
      actions: [
        FlatButton(
          child: Text("네"),
          onPressed: () {
            deletePost(_postId);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
              (Route<dynamic> route) => false,
            );
          },
        ),
        FlatButton(
          child: Text("아니요"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ),
  );
}
