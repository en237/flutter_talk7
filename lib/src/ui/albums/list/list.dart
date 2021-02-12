import 'package:flutter/material.dart';
import 'package:flutter_talk7/src/core/models/models.dart';
import 'package:flutter_talk7/src/core/services/services.dart';
import 'package:flutter_talk7/src/ui/ui.dart';

class AlbumListPage extends StatefulWidget {
  @override
  _AlbumListPageState createState() => _AlbumListPageState();
}

class _AlbumListPageState extends State<AlbumListPage> {
  List<User> userList = [];
  List<Album> albumList = [];
  final api = getRestClient();
  bool loading = false;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    api.getUsers().then((value) => setState(() {
          userList = value;
        }));
    _refreshAlbums();
  }

  _refreshAlbums() async {
    setState(() {
      loading = true;
    });
    try {
      final value = await api.getAlbums();
      setState(() {
        albumList = value;
      });
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Albums list"),
        actions: [
          loading
              ? CircularProgressIndicator()
              : IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: _refreshAlbums,
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AlbumNewPage(
                        users: userList,
                      )));
          if ((result != null) && (result is Album)) {
            setState(() {
              albumList.add(result);
            });
            _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
          }
        },
        child: Icon(Icons.add),
      ),
      body: ListView.separated(
        controller: _scrollController,
        itemBuilder: (context, index) {
          final album = albumList[index];
          final user = userList.firstWhere((e) => e.id == album.userId, orElse: () => User());
          return ListTile(
            title: Text("${album.title}"),
            subtitle: Text("${user.name}"),
            trailing: Text("${album.id}"),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AlbumViewPage(album: album, user: user))),
            onLongPress: () async {
              final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => AlbumEditPage(album: album)));
              if ((result != null) && (result is Album)) {
                setState(() {
                  albumList[index] = result;
                });
              }
            },
          );
        },
        separatorBuilder: (_, __) => Divider(height: 1, indent: 16),
        itemCount: albumList.length,
      ),
    );
  }
}
