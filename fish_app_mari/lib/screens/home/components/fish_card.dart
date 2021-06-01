import 'dart:io';
import 'package:flutter/material.dart';

import 'package:fish_app_mari/model/post.dart';
import '../../../constants.dart';

class FishCard extends StatelessWidget {
  const FishCard({
    this.post,
    @required PostPressedCallback onPostPressed,
  }) : _onPressed = onPostPressed;

  final Post post;
  final PostPressedCallback _onPressed;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: kDefaultPadding,
        horizontal: kDefaultPadding + 20,
      ),
      width: size.width * 0.8,
      child: Column(
        children: <Widget>[
          Image.network(post.imageURL),
          GestureDetector(
            onTap: () => _onPressed(post.id),
            child: Container(
              padding: EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: kPrimaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "${post.title}\n",
                            style: Theme.of(context).textTheme.button),
                        TextSpan(
                          text: "${post.creationTime.toDate()}",
                          style: TextStyle(
                            color: kPrimaryColor.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    child: Text(
                      '${post.writer}',
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .copyWith(color: kPrimaryColor),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
