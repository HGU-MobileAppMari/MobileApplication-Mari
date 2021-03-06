import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

import 'package:fish_app_mari/model/post.dart';
import 'package:fish_app_mari/model/post_transaction.dart';

class PostAddScreen extends StatefulWidget {
  @override
  _PostAddScreenState createState() => _PostAddScreenState();
}

class _PostAddScreenState extends State<PostAddScreen> {
  File _image;
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>(debugLabel: '_PostAddScreenState');
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

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
                  hintText: '제목',
                  hintStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '계속하려면 제목을 입력하세요';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  hintText: '설명',
                ),
                maxLines: 15,
                //keyboardType: TextInputType.multiline,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '계속하려면 설명을 입력하세요';
                  }
                  return null;
                },
              ),
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
              child: Text('취소'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Padding(
              padding: EdgeInsets.only(left: 90.0, right: 80.0),
              child: Text(
                '작성',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
              ),
              child: Text('저장'),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  Timestamp createdTime = Timestamp.now();
                  String imageName = createdTime.toString() +
                      "_" +
                      _firebaseAuth.currentUser.uid;
                  Reference ref = FirebaseStorage.instance
                      .ref()
                      .child('posts')
                      .child(imageName);
                  await ref.putFile(File(_image.path));
                  var url = await ref.getDownloadURL();

                  addPost(
                    Post(
                      userId: _firebaseAuth.currentUser.uid,
                      writer: _firebaseAuth.currentUser.displayName,
                      title: _titleController.text,
                      description: _descriptionController.text,
                      imageURL: url,
                      creationTime: createdTime,
                    ),
                  );
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          imageSection,
          iconSection,
          textSection,
        ],
      ),
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
