import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

import 'package:fish_app_mari/model/post.dart';
import 'package:fish_app_mari/model/post_transaction.dart';

//image edit problem
class PostEditScreen extends StatefulWidget {
  PostEditScreen({
    Key key,
    @required String postId,
  })  : _postId = postId,
        super(key: key);
  final String _postId;

  @override
  _PostEditScreenState createState() => _PostEditScreenState(postId: _postId);
}

class _PostEditScreenState extends State<PostEditScreen> {
  File _image;
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>(debugLabel: '_PostEditScreenState');

  Post _post;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  _PostEditScreenState({@required String postId}) {
    getPost(postId).then((Post post) {
      setState(() {
        _post = post;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final _titleController = TextEditingController(text: '${_post.title}');
    final _descriptionController =
        TextEditingController(text: '${_post.description}');
    Widget imageSection = Container(
      child: _image == null
          ? Image.network(
              _post.imageURL,
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
                controller: _descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Description',
                ),
                maxLines: 15,
                //keyboardType: TextInputType.multiline,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter description to continue';
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
                '수정',
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
                  String imageName =
                      _post.creationTime.toString() + "_" + _post.userId;
                  Reference ref = FirebaseStorage.instance
                      .ref()
                      .child('posts')
                      .child(imageName);
                  if (_image != null) {
                    await ref.putFile(File(_image.path));
                  }

                  var url = await ref.getDownloadURL();

                  editPost(
                    widget._postId,
                    _titleController.text,
                    _descriptionController.text,
                    url,
                  );
                  Navigator.pop(context, widget._postId);
                  Navigator.pop(context, widget._postId);
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
