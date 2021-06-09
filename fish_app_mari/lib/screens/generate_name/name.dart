import 'package:flutter/material.dart';
import 'package:fish_app_mari/model/name_transaction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'title.dart';


class NamePage extends StatefulWidget {
  @override
  _NamePageState createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {

  final _biggerFont = TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser.uid.toString();

    return Scaffold(
      body:
      Column(
        children: [
          SizedBox(height: 5),
          TitleWithCustomUnderline(text: "이름 짓기"),
          SizedBox(height: 5),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('name').snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    return ListView.separated(
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          List users = snapshot.data.docs[index]['users'].toList();
                          String name = snapshot.data.docs[index]['name'];

                          return ListTile(
                              title: Text(name, style: _biggerFont),
                              leading: Icon(
                                  users.contains(uid)? Icons.star : Icons.star_border,
                                  color: users.contains(uid)? Colors.yellow[600] : Colors.grey,
                                  size: 33.0
                              ),
                              onTap: () async {
                                setState(() {
                                  if(users.contains(uid)) {
                                    // remove
                                    removeFromFavorite(name);
                                  }
                                  else {
                                    // add
                                    addToFavorite(name);
                                  }
                                });
                              }
                          );
                        }
                    );
                  }
                  else {
                    return Container();
                  }
                }
            ),
          )
        ],
      )
    );
  }
}