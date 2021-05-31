import 'package:flutter/material.dart';
import 'package:fish_app_mari/constants.dart';

import 'image_and_text.dart';
// import 'title_and_price.dart';

class Body extends StatelessWidget {
  final String _postId;

  Body({
    @required String postId,
  }) : _postId = postId;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print('get and give $_postId');
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ImageAndText(postId: _postId),
          // TitleAndPrice(title: "Angelica", country: "Russia", price: 440),
          SizedBox(height: kDefaultPadding),
          Row(
            children: <Widget>[
              SizedBox(
                width: size.width / 2,
                height: 84,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                    ),
                  ),
                  color: kPrimaryColor,
                  onPressed: () {},
                  child: Text(
                    "Buy Now",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: FlatButton(
                  onPressed: () {},
                  child: Text("Description"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}