import 'package:flutter/material.dart';
import 'package:fish_app_mari/constants.dart';
import 'adopt_add.dart';
import 'posted_adopt_fish.dart';

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
                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: kPrimaryColor,
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdoptAddScreen(),
                        ),
                      );
                    },
                    child: Text(
                      " + NEW ADOPT",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  PostedFish(),
                ]
            ),
          ),
        )
    );
  }
}
