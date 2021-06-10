import 'package:flutter/material.dart';
import 'adopt_add.dart';
import 'posted_adopt_fish.dart';
import 'title_with_more_bbtn.dart';

class AdoptPage extends StatefulWidget {
  @override
  _AdoptPageState createState() => _AdoptPageState();
}

class _AdoptPageState extends State<AdoptPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Column(
                children: [
                  SizedBox(height: 10),
                  TitleWithMoreBtn(
                      title: "내 물고기 분양시키기",
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdoptAddScreen(),
                          ),
                        );
                      }),
                  PostedFish(),
                ]
            ),
          ),
        )
    );
  }
}
