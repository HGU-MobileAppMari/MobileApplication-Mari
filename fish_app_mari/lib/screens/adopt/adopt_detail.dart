import 'package:fish_app_mari/components/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:fish_app_mari/constants.dart';
import 'package:fish_app_mari/screens/adopt/adopt_image_and_text.dart';
import 'package:fish_app_mari/auth_service.dart';
import 'package:fish_app_mari/auth_provider.dart';

class AdoptDetailScreen extends StatelessWidget {
  final String _postId;

  AdoptDetailScreen({
    @required String postId,
  }) : _postId = postId;

  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return Scaffold(
        appBar: MyAppbar(auth: auth),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ImageAndText(postId: _postId),
              SizedBox(height: kDefaultPadding),
            ],
          ),
        )
    );
  }
}

class AdoptPostDetailScreenArguments {
  final String id;
  AdoptPostDetailScreenArguments({@required this.id});
}