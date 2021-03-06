import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RawHttpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int albumId = Random().nextInt(100);
    // int albumId = 101;// uncomment to trigger an unexpected status code
    return Scaffold(
      appBar: AppBar(
        title: Text("Raw HTTP Call"),
      ),
      body: Center(
        child: FutureBuilder<http.Response>(
          future: http.get(Uri.https('jsonplaceholder.typicode.com', 'albums/$albumId')),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text("${snapshot.data.body}");
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
