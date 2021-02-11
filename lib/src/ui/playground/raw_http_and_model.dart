import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_talk7/src/core/models/models.dart';
import 'package:http/http.dart' as http;

class RawHttpAndModelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int albumId = Random().nextInt(100);
    // int albumId = 101;// uncomment to trigger an unexpected status code
    return Scaffold(
      appBar: AppBar(
        title: Text("Raw HTTP And Deserialization"),
      ),
      body: Center(
        child: FutureBuilder<http.Response>(
          future: http.get(Uri.https('jsonplaceholder.typicode.com', 'albums/$albumId')),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.statusCode != 200) {
                return Text("Bad Status Code: ${snapshot.data.statusCode} - ${snapshot.data.reasonPhrase}");
              }
              Map data = jsonDecode(snapshot.data.body);
              final album = Album.fromJson(data);
              return Text("$album\n\nAlbum ID = ${album.id}\nTitle = ${album.title}");
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
