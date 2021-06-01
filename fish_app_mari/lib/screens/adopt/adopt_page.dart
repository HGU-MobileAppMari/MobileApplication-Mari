import 'package:flutter/material.dart';
import 'package:fish_app_mari/constants.dart';
import 'package:fish_app_mari/model/adopt_post.dart';
import 'adopt_add.dart';
import 'posted_adopt_fish.dart';

class AdoptPage extends StatefulWidget {
  @override
  _AdoptPageState createState() => _AdoptPageState();
}

class _AdoptPageState extends State<AdoptPage> {

  List<AdoptPost> posts = [
    AdoptPost(
        fishName: "yellow fauna",
        writer: "Brianne",
        writerImage:
        "https://s3.amazonaws.com/uifaces/faces/twitter/felipecsl/128.jpg",
        postImageURL: "https://w7.pngwing.com/pngs/631/631/png-transparent-fish-iridescent-shark-fish-15-purple-animals-fauna.png",
        description: "Consequatur nihil aliquid omnis consequatur."),
    AdoptPost(
        writer:  "Henri",
        writerImage: "https://s3.amazonaws.com/uifaces/faces/twitter/kevka/128.jpg",
        postImageURL:
        "https://img.sbs.co.kr/newimg/news/20160420/200935703_1280.jpg",
        description: "Consequatur nihil aliquid omnis consequatur."),
  ];


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
              SizedBox(height: kDefaultPadding),
              // Container(
              //   width: MediaQuery.of(context).size.width,
              //   child: ListView.builder(
              //     shrinkWrap: true,
              //     physics: NeverScrollableScrollPhysics(),
              //     itemCount: posts.length,
              //     itemBuilder: (ctx, i) {
              //       return Container(
              //         color: Colors.white,
              //         child: Column(
              //           children: <Widget>[
              //             Container(
              //               padding: EdgeInsets.symmetric(
              //                 horizontal: 10,
              //                 vertical: 10,
              //               ),
              //               child: Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                 children: <Widget>[
              //                   Row(
              //                     children: <Widget>[
              //                       ClipRRect(
              //                         borderRadius: BorderRadius.circular(40),
              //                         child: Image(
              //                           image: NetworkImage(posts[i].writerImage),
              //                           width: 40,
              //                           height: 40,
              //                           fit: BoxFit.cover,
              //                         ),
              //                       ),
              //                       SizedBox(
              //                         width: 10,
              //                       ),
              //                       Text(posts[i].writer),
              //                     ],
              //                   ),
              //                   // IconButton(
              //                   //   icon: Icon(SimpleLineIcons.options),
              //                   //   onPressed: () {},
              //                   // ),
              //                 ],
              //               ),
              //             ),
              //
              //             FadeInImage(
              //               image: NetworkImage(posts[i].postImageURL),
              //               placeholder: AssetImage("assets/placeholder.png"),
              //               width: MediaQuery.of(context).size.width,
              //             ),
              //
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: <Widget>[
              //                 Row(),
              //                 IconButton(
              //                   onPressed: () {},
              //                   icon: Icon(Icons.book_outlined),
              //                 ),
              //               ],
              //             ),
              //
              //             Container(
              //               width: MediaQuery.of(context).size.width,
              //               margin: EdgeInsets.symmetric(
              //                 horizontal: 14,
              //               ),
              //               child: RichText(
              //                 softWrap: true,
              //                 overflow: TextOverflow.visible,
              //                 text: TextSpan(
              //                   children: []
              //                 ),
              //               ),
              //             ),
              //
              //             // caption
              //             Container(
              //               width: MediaQuery.of(context).size.width,
              //               margin: EdgeInsets.symmetric(
              //                 horizontal: 14,
              //                 vertical: 5,
              //               ),
              //               child: RichText(
              //                 softWrap: true,
              //                 overflow: TextOverflow.visible,
              //                 text: TextSpan(
              //                   children: [
              //                     TextSpan(
              //                       text: posts[i].writer,
              //                       style: TextStyle(
              //                           fontWeight: FontWeight.bold,
              //                           color: Colors.black),
              //                     ),
              //                     TextSpan(
              //                       text: " ${posts[i].description}",
              //                       style: TextStyle(color: Colors.black),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             ),
              //
              //             // post date
              //             Container(
              //               margin: EdgeInsets.symmetric(
              //                 horizontal: 14,
              //               ),
              //               alignment: Alignment.topLeft,
              //               child: Text(
              //                 "Febuary 2020",
              //                 textAlign: TextAlign.start,
              //                 style: TextStyle(
              //                   color: Colors.grey,
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      )
    );
  }
}
