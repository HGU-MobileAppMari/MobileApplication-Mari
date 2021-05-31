import 'package:flutter/material.dart';
import 'package:fish_app_mari/constants.dart';
import 'package:fish_app_mari/model/adopt_post.dart';


class AdoptPage extends StatefulWidget {
  @override
  _AdoptPageState createState() => _AdoptPageState();
}

class _AdoptPageState extends State<AdoptPage> {

  void getAllAdoptPosts(){

  }

  List<AdoptPost> posts = [
    AdoptPost(
        fishName: "yellow fauna",
        userName: "Brianne",
        userImage:
        "https://s3.amazonaws.com/uifaces/faces/twitter/felipecsl/128.jpg",
        postImage: "https://w7.pngwing.com/pngs/631/631/png-transparent-fish-iridescent-shark-fish-15-purple-animals-fauna.png",
        caption: "Consequatur nihil aliquid omnis consequatur."),
    AdoptPost(
        userName: "Henri",
        userImage:
        "https://s3.amazonaws.com/uifaces/faces/twitter/kevka/128.jpg",
        postImage:
        "https://img.sbs.co.kr/newimg/news/20160420/200935703_1280.jpg",
        caption: "Consequatur nihil aliquid omnis consequatur."),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: kPrimaryColor,
                onPressed: (){},
                child: Text(
                  "ADD",
                  style: TextStyle(color: Colors.white),
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: posts.length,
                  itemBuilder: (ctx, i) {
                    return Container(
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: Image(
                                        image: NetworkImage(posts[i].userImage),
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(posts[i].userName),
                                  ],
                                ),
                                // IconButton(
                                //   icon: Icon(SimpleLineIcons.options),
                                //   onPressed: () {},
                                // ),
                              ],
                            ),
                          ),

                          FadeInImage(
                            image: NetworkImage(posts[i].postImage),
                            placeholder: AssetImage("assets/placeholder.png"),
                            width: MediaQuery.of(context).size.width,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.book_outlined),
                              ),
                            ],
                          ),

                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(
                              horizontal: 14,
                            ),
                            child: RichText(
                              softWrap: true,
                              overflow: TextOverflow.visible,
                              text: TextSpan(
                                children: []
                              ),
                            ),
                          ),

                          // caption
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 5,
                            ),
                            child: RichText(
                              softWrap: true,
                              overflow: TextOverflow.visible,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: posts[i].userName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: " ${posts[i].caption}",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // post date
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 14,
                            ),
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Febuary 2020",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
