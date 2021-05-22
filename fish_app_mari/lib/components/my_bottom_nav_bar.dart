import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../screens/dictionary/dictionary_screen.dart';
import '../constants.dart';

class MyBottomNavBar extends StatelessWidget {
  const MyBottomNavBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: kDefaultPadding * 2,
        right: kDefaultPadding * 2,
        bottom: kDefaultPadding,
      ),
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -10),
            blurRadius: 35,
            color: kPrimaryColor.withOpacity(0.38),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          iconWithText(Icon(Icons.home_outlined), '어항 자랑', () {}),
          iconWithText(Icon(Icons.menu_book_outlined), '사전', () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DictionaryScreen(),
              ),
            );
          }),
          iconWithText(Icon(Icons.shopping_cart_outlined), '분양', () {}),
          iconWithText(Icon(Icons.location_on_outlined), '가게', () {}),
          iconWithText(Icon(Icons.set_meal_outlined), '이름 짓기', () {}),
        ],
      ),
    );
  }

  Column iconWithText(Icon icon, String text, Function press) {
    return Column(
      children: [
        IconButton(
          icon: icon,
          color: kTextColor,
          onPressed: press,
        ),
        Text(
          text,
          style: TextStyle(
            color: kTextColor,
            fontSize: 14.0,
          ),
        ),
      ],
    );
  }
}
