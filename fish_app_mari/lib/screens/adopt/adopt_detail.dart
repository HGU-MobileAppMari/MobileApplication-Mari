import 'package:fish_app_mari/components/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:fish_app_mari/constants.dart';
import 'package:fish_app_mari/screens/adopt/adopt_image_and_text.dart';
import 'package:fish_app_mari/auth_service.dart';
import 'package:fish_app_mari/auth_provider.dart';
import 'unicorn_button.dart';
import 'adopt_post_edit.dart';
import 'adopt_delete_alert.dart';

class AdoptDetailScreen extends StatelessWidget {
  final String _postId;
  final String _userId;

  AdoptDetailScreen({
    @required String postId,
    @required String userId,
  }) : _postId = postId,
       _userId = userId;

  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
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
              builder: (context) => AdoptPostEditScreen(postId: _postId),
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
        ),
      ),
    );

    return Scaffold(
        appBar: MyAppbar(auth: auth),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ImageAndText(postId: _postId),
              SizedBox(height: kDefaultPadding),
            ],
          ),
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

class AdoptPostDetailScreenArguments {
  final String id;
  AdoptPostDetailScreenArguments({@required this.id});
}