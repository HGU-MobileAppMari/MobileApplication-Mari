import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fish_app_mari/model/adopt_post.dart';
import 'package:fish_app_mari/constants.dart';

class AdoptCard extends StatelessWidget {
  const AdoptCard({
    this.adoptPost,
    @required PostPressedCallback onPostPressed,
  }) : _onPressed = onPostPressed;

  final AdoptPost adoptPost;
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
          Image.network(adoptPost.postImageURL),
          GestureDetector(
            onTap: () => _onPressed(adoptPost.id, adoptPost.userId),
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
                    blurRadius: 30, // 50?
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
                            text: "${adoptPost.title}\n",
                            style: Theme.of(context).textTheme.button),
                        TextSpan(
                          text: "${DateFormat('yyyy년 MM월 dd일 kk시mm분').format(adoptPost.createdAt.toDate())}",
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
                      '${adoptPost.writer}',
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
