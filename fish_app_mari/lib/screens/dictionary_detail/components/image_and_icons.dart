import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../constants.dart';
import 'title_and_subtitle.dart';
import 'icon_card.dart';

class ImageAndIcons extends StatefulWidget {
  ImageAndIcons({
    Key key,
    this.size,
    @required String name,
  })  : _name = name,
        super(key: key);

  final Size size;
  final String _name;

  @override
  _ImageAndIconsState createState() => _ImageAndIconsState(name: _name);
}

class _ImageAndIconsState extends State<ImageAndIcons> {
  bool _isLoading = true;
  String _name;
  String _imageName;
  String _description;
  String _imageURL;

  _ImageAndIconsState({@required String name}) {
    FirebaseFirestore.instance
        .collection('dictionary')
        .where('name', isEqualTo: name)
        .get()
        .then((doc) {
      setState(() {
        _name = doc.docs.first.data()['name'];
        _imageName = doc.docs.first.data()['image'];
        _description = doc.docs.first.data()['description'];
        FirebaseStorage.instance
            .ref()
            .child("dictionary")
            .child("$_imageName.jpeg")
            .getDownloadURL()
            .then((value) {
          setState(() {
            _isLoading = false;
            _imageURL = value.toString();
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.only(bottom: kDefaultPadding * 3),
            child: SizedBox(
              height: widget.size.height * 1.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TitleAndSubtitle(title: _name, subtitle: _imageName),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Column(
                            children: <Widget>[
                              IconCard(icon: "assets/icons/aquarium.svg"),
                              IconCard(icon: "assets/icons/fishing-net.svg"),
                              IconCard(icon: "assets/icons/seaweed.svg"),
                              IconCard(icon: "assets/icons/fish-bowl.svg"),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 390,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(63),
                            bottomLeft: Radius.circular(63),
                          ),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 60,
                              color: kPrimaryColor.withOpacity(0.29),
                            ),
                          ],
                          image: DecorationImage(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.fill,
                            image: NetworkImage(_imageURL),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Text('$_description',
                        style: TextStyle(
                          fontSize: 15.0,
                          height: 1.5,
                        )),
                  ),
                ],
              ),
            ),
          );
  }
}
