import 'dart:io';

import 'package:crudapp/models/album_model.dart';
import 'package:crudapp/services/api_services.dart';
import 'package:crudapp/views/add_album_screen.dart';
import 'package:crudapp/views/edit_album.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../controllers/album_providers.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int? tileIndex = 0;
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "FreeMob",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      )),
      drawer: Drawer(),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {},
          child: FutureBuilder<List<Album>>(
            future: context.read<AlbumProvider>().fetchAlbums(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  List<Album> albums = snapshot.data!;
                  return Container(
                    padding: EdgeInsets.all(10),
                    child: ListView.separated(
                      itemCount: albums.length,
                      separatorBuilder: (context, index) => Divider(),
                      itemBuilder: (context, index) {
                        Album album = albums[index];
                        return ListTile(
                          title: Text(
                            "${album.id}. ${album.title}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          tileColor: (tileIndex == album.id)
                              ? Colors.white
                              : Colors.green[100],
                          onTap: () {
                            setState(() {
                              tileIndex = album.id;
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return EditAlbumPage(album: album);
                              }));
                            });
                          },
                        );
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: Text("${snapshot.error}"),
                  );
                }
              } else {
                return Center(
                  child: Platform.isAndroid
                      ? CircularProgressIndicator()
                      : CupertinoActivityIndicator(),
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AddAlbumScreen();
              },
            ),
          );
        },
        child: Icon(Icons.add),
        tooltip: "Add new album",
      ),
    );
  }
}
