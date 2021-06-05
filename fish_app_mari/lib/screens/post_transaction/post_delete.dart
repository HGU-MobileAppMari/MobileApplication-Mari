import 'package:flutter/material.dart';

import 'package:fish_app_mari/model/post_transaction.dart';

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
            Navigator.pop(context);
            Navigator.pop(context);
            deletePost(_postId);
            // Navigator.pushNamedAndRemoveUntil(
            //   context,
            //   '/home',
            //   (route) => false,
            // );
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

// class PostDeleteDialog extends StatelessWidget {
//   PostDeleteDialog({
//     Key key,
//     @required String postId,
//   })  : _postId = postId,
//         super(key: key);

//   String _postId;

//   Future<void> showDeleteDialog(BuildContext context) async {
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         title: Text("삭제?"),
//         content: Text("정말로 삭제하시겠습니까?"),
//         actions: [
//           FlatButton(
//             child: Text("네"),
//             onPressed: () => deletePost(_postId),
//           ),
//           FlatButton(
//             child: Text("아니요"),
//             onPressed: () => Navigator.pop(context),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }