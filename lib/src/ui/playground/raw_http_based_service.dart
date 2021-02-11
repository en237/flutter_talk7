import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_talk7/src/core/models/models.dart';
import 'package:http/http.dart' as http;

class RawHttpServicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final service = AlbumService();
    int albumId = Random().nextInt(100);
    // int albumId = 101;// uncomment to trigger an unexpected status code
    return Scaffold(
        appBar: AppBar(
          title: Text("Raw HTTP And Deserialization"),
        ),
        body: Column(
          children: <Widget>[
            FutureBuilder<Album>(
              future: service.getAlbum(albumId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final album = snapshot.data;
                  return Text("$album\n\nAlbum ID = ${album.id}\nTitle = ${album.title}");
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              },
            ),
            SizedBox(
              height: 24,
            ),
            Expanded(
              child: FutureBuilder<List<Album>>(
                future: service.getAlbums(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final albumList = snapshot.data;
                    return ListView.separated(
                      itemCount: albumList.length,
                      separatorBuilder: (context, index) => Divider(),
                      itemBuilder: (context, index) => ListTile(
                        title: Text("${albumList[index].title}"),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
          ],
        ));
  }
}

class AlbumService {
  Future<Album> getAlbum(id) async {
    final response = await http.get(Uri.https('jsonplaceholder.typicode.com', 'albums/$id'));
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      return Album.fromJson(data);
    } else {
      throw Exception("${response.statusCode} - ${response.reasonPhrase}");
    }
  }

  Future<List<Album>> getAlbums() async {
    final response = await http.get(Uri.https('jsonplaceholder.typicode.com', 'albums'), headers: {'Accept': "application/json"});
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Album.fromJson(e)).toList();
    } else {
      throw Exception("${response.statusCode} - ${response.reasonPhrase}");
    }
  }
}
