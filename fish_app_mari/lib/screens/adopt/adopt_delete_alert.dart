import 'package:flutter/material.dart';
import 'package:fish_app_mari/model/adopt_post_transaction.dart';

Future<void> showDeleteDialog(BuildContext context, String _postId) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text("삭제?"),
      content: Text("정말로 삭제하시겠습니까?"),
      actions: [
        TextButton(
          child: Text("네"),
          onPressed: () {
            deleteAdoptPost(_postId);
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text("아니요"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ),
  );
}