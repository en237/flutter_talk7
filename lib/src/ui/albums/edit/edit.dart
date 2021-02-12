import 'package:flutter/material.dart';
import 'package:flutter_talk7/src/core/models/models.dart';
import 'package:flutter_talk7/src/core/services/services.dart';

class AlbumEditPage extends StatefulWidget {
  final Album album;

  const AlbumEditPage({Key key, @required this.album}) : super(key: key);
  @override
  _AlbumEditPageState createState() => _AlbumEditPageState();
}

class _AlbumEditPageState extends State<AlbumEditPage> {
  final _ctlTitle = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ctlTitle.text = widget.album.title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Album #${widget.album.id}"),
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
                widget.album.title = _ctlTitle.text;
                try {
                  final response = await getRestClient().updateAlbum(widget.album.id, widget.album);
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
              icon: Icon(Icons.save),
              label: Text("Save"),
            ),
          ],
        ));
  }
}
