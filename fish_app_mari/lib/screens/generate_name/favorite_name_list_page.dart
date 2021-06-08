import 'package:flutter/material.dart';
import 'package:fish_app_mari/components/my_appbar.dart';
import 'package:fish_app_mari/auth_service.dart';
import 'package:fish_app_mari/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_app_mari/model/name_transaction.dart';

class MyFavoritesPage extends StatefulWidget {
  @override
  _MyFavoritesPageState createState() => _MyFavoritesPageState();
}

class _MyFavoritesPageState extends State<MyFavoritesPage> {
  final _biggerFont = TextStyle(fontSize: 18.0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    String uid = auth.firebaseAuth.currentUser.uid.toString();

    return Scaffold(
      appBar: MyAppbar(auth: auth),
      body:
        Container(
          child:
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('name').where('users', arrayContains: uid)
                .snapshots(),
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                return  ListView.separated(
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      String name = snapshot.data.docs[index]['name'];

                      return ListTile(
                          title: Text(snapshot.data.docs[index]['name'], style: _biggerFont),
                          leading: Icon(
                              Icons.star,
                              color: Colors.yellow[600],
                              size: 33.0
                          ),
                          onTap: (){
                            setState(() {
                              removeFromFavorite(name);
                            });
                          }
                      );
                    }
                );
              }
              else {
                return Container();
              }
            },
          ),
        )
    );
  }
}
