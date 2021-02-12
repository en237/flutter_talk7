import 'package:flutter/material.dart';
import 'package:flutter_talk7/src/core/models/models.dart';
import 'package:flutter_talk7/src/core/services/services.dart';

class AlbumNewPage extends StatefulWidget {
  final List<User> users;

  const AlbumNewPage({Key key, @required this.users}) : super(key: key);
  @override
  _AlbumNewPageState createState() => _AlbumNewPageState();
}

class _AlbumNewPageState extends State<AlbumNewPage> {
  final _ctlTitle = TextEditingController();
  int _userId = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create Album"),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(height: 24),
            TextField(
              controller: _ctlTitle,
            ),
            SizedBox(height: 36),
            ElevatedButton.icon(
              onPressed: () async {
                final album = new Album(
                  title: _ctlTitle.text,
                  userId: _userId,
                );
                try {
                  final response = await getRestClient().createAlbum(album);
                  Navigator.pop(context, response);
                } catch (e) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("An Error Occured"),
                      content: Text("$e"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("OK"),
                        ),
                      ],
                    ),
                  );
                }
              },
              icon: Icon(Icons.save_outlined),
              label: Text("Create"),
            ),
          ],
        ));
  }
}
