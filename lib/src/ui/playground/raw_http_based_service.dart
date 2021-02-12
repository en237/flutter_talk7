import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_talk7/src/core/models/models.dart';
import 'package:flutter_talk7/src/core/services/services.dart';
import 'package:http/http.dart' as http;

class RawHttpServicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final service = getRestClient();
    int albumId = Random().nextInt(100);
    // int albumId = 101;// uncomment to trigger an unexpected status code
    return Scaffold(
        appBar: AppBar(
          title: Text("HTTP With Raw Service"),
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
                    return Center(
                      child: Text("${snapshot.error}"),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
