import 'package:flutter/material.dart';

class PhotoViewPage extends StatelessWidget {
  final String photoUrl;
  final String title;

  const PhotoViewPage({Key key, @required this.photoUrl, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$title"),
      ),
      body: Image.network(photoUrl),
    );
  }
}
