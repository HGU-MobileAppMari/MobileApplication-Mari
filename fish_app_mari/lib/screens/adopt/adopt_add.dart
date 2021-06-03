import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fish_app_mari/model/adopt_post.dart';
import 'package:fish_app_mari/model/adopt_post_transaction.dart';

class AdoptAddScreen extends StatefulWidget {
  @override
  _AdoptPostAddScreenState createState() => _AdoptPostAddScreenState();
}

class _AdoptPostAddScreenState extends State<AdoptAddScreen> {
  File _image;
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>(debugLabel: '_AdoptPostAddScreenState');
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _fishNameController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _locationList = [ "전국", "서울", "경기", "인천", "강원", "충북",
                          "충남", "대전", "경북", "대구", "전북", "경남",
                          "울산", "부산", "광주", "전남", "제"];
  var _selectedLocation= "전국";

  @override
  Widget build(BuildContext context) {
    Widget imageSection = Container(
      child: _image == null
          ? Image.asset(
              'assets/images/logo.png',
              width: 600,
              height: 240,
              fit: BoxFit.fitHeight,
            )
          : Image.file(
              _image,
              width: 600,
              height: 240,
              fit: BoxFit.fitWidth,
            ),
    );

    Widget iconSection = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        IconButton(
            icon: Icon(Icons.photo_camera),
            onPressed: () {
              getImage();
            }),
      ],
    );

    Widget textSection = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.only(left: 50.0, right: 50.0),
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'Title',
                  hintStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter title to continue';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _fishNameController,
                decoration: const InputDecoration(
                  hintText: 'Fish name',
                ),
                maxLines: 1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter fish name to continue';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Description',
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter description to continue';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Text("판매 지역: "),
                  SizedBox(width: 30),
                  DropdownButton(
                    value: _selectedLocation,
                    items: _locationList.map((value){
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value){
                      setState(() {
                        _selectedLocation = value;
                      });
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
              ),
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Padding(
              padding: EdgeInsets.only(left: 90.0, right: 80.0),
              child: Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
              ),
              child: Text('Save'),
              onPressed: () async {

                if (_formKey.currentState.validate()) {

                  Timestamp currentTime = Timestamp.now();
                  String imageName = currentTime.toString() + "_" + _firebaseAuth.currentUser.uid;
                  Reference ref = FirebaseStorage.instance.ref().child('adopt_post').child(imageName);
                  await ref.putFile(File(_image.path));
                  var url = await ref.getDownloadURL();

                  addAdoptPost(
                    AdoptPost(
                      id: _firebaseAuth.currentUser.uid,
                      writer: _firebaseAuth.currentUser.displayName,
                      writerImage: _firebaseAuth.currentUser.photoURL,
                      title: _titleController.text,
                      fishName: _fishNameController.text,
                      description: _descriptionController.text,
                      postImageURL: url,
                      location: _selectedLocation,
                      createdAt: currentTime,
                    ),
                  );
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            imageSection,
            iconSection,
            textSection,
          ],
        ),
      )
    );
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected');
      }
    });
  }
}
