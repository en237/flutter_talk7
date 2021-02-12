import 'package:flutter/material.dart';
import 'package:flutter_talk7/src/core/models/models.dart';
import 'package:flutter_talk7/src/core/services/services.dart';

class AlbumViewPage extends StatelessWidget {
  final Album album;
  final User user;

  const AlbumViewPage({
    Key key,
    @required this.album,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final api = getRestClient();
    return Scaffold(
      appBar: AppBar(
        title: Text("Album #${album.id}"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 16, width: double.maxFinite),
          Text("Title:"),
          SizedBox(height: 16),
          Text("${album.title}", style: Theme.of(context).textTheme.headline6),
          SizedBox(height: 16),
          Text("User:"),
          SizedBox(height: 16),
          Text("${user.name}", style: Theme.of(context).textTheme.bodyText1),
          SizedBox(height: 32),
          Text("Photos:"),
          SizedBox(height: 16),
          Expanded(
            child: FutureBuilder<List<Photo>>(
              future: api.getAlbumPhotos(album.id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final photos = snapshot.data;
                  return GridView.count(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    children: photos.map((e) => Image.network(e.thumbnailUrl)).toList(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(child: Text("${snapshot.error}"));
                }
                if ([ConnectionState.done, ConnectionState.none].contains(snapshot.connectionState)) {
                  return Center(
                    child: Text("No data"),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
