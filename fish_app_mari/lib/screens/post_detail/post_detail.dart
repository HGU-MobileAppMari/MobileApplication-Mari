import 'package:flutter/material.dart';

import 'package:fish_app_mari/auth_service.dart';
import 'package:fish_app_mari/auth_provider.dart';
import 'package:fish_app_mari/components/my_appbar.dart';
import 'package:fish_app_mari/screens/post_detail/components/body.dart';

class PostDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;

    return Scaffold(
      appBar: MyAppbar(auth: auth),
      body: Body(),
    );
  }
}
