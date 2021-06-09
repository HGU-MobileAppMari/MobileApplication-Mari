import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fish_app_mari/model/adopt_post.dart';
import 'package:fish_app_mari/screens/adopt/adopt_detail.dart';
import 'package:fish_app_mari/model/adopt_post_transaction.dart';

//image edit problem
class AdoptPostEditScreen extends StatefulWidget {
  AdoptPostEditScreen({
    Key key,
    @required String postId,
  })  : _postId = postId,
        super(key: key);
  final String _postId;

  @override
  _AdoptPostEditScreenState createState() => _AdoptPostEditScreenState(postId: _postId);
}

class _AdoptPostEditScreenState extends State<AdoptPostEditScreen> {
  File _image;
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>(debugLabel: '_PostEditScreenState');
  AdoptPost _post;
  var _selectedLocation;

  _AdoptPostEditScreenState({@required String postId}) {
    getAdoptPost(postId).then((AdoptPost post) {
      setState(() {
        _post = post;
        _selectedLocation = _post.location;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final _titleController = TextEditingController(text: '${_post.title}');
    final _descriptionController = TextEditingController(text: '${_post.description}');
    final _fishNameController = TextEditingController(text: '${_post.fishName}');
    final _locationList = [ "전국", "서울", "경기", "인천", "강원", "충북",
      "충남", "대전", "경북", "대구", "전북", "경남",
      "울산", "부산", "광주", "전남", "제주"];

    Widget imageSection = Container(
      padding: EdgeInsets.all(10),
      child: _image == null
          ? Image.network(
        _post.postImageURL,
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
                  labelText: 'Title',
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
                  labelText: 'Description',
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter description to continue';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _fishNameController,
                decoration: const InputDecoration(
                  labelText: 'Fish name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter fish name to continue';
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
                'Edit',
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
                      _post.createdAt.toString() + "_" + _post.id;
                  Reference ref = FirebaseStorage.instance
                      .ref()
                      .child('adopt_post')
                      .child(imageName);

                  if (_image != null) {
                    await ref.putFile(File(_image.path));
                    var url = await ref.getDownloadURL();
                    editAdoptPost(
                        widget._postId,
                        _titleController.text,
                        _descriptionController.text,
                        url,
                        _fishNameController.text,
                        _selectedLocation
                    );
                  }
                  else {
                    editAdoptPost(
                        widget._postId,
                        _titleController.text,
                        _descriptionController.text,
                        _post.postImageURL,
                        _fishNameController.text,
                        _selectedLocation
                    );
                  }
                  Navigator.pop(context, widget._postId);
                  Navigator.pop(context, widget._postId);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdoptDetailScreen(postId: widget._postId, userId: _post.userId)),
                  );
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
