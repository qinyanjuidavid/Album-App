import 'dart:convert';

import 'package:crudapp/models/album_model.dart';
import 'package:crudapp/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AlbumProvider extends ChangeNotifier {
  final baseUrl = "https://jsonplaceholder.typicode.com/albums/";
  Future<List<Album>> fetchAlbums() async {
    List<Album> albums = await ApiService.getAlbumsApi();
    return albums;
    notifyListeners();
  }

  Future<Album> createAlbumProvider(String title) async {
    print("Creating album...");
    var album = await ApiService.createAlbumApi(title);
    print("Album created ${album.title}");
    return album;
    notifyListeners();
  }

  Future<Album> updateAlbumProvider(String title, int? id) async {
    print("Updating album....");
    var album = await ApiService.updateAlbumApi(title, id!);
    print("Album updated ${album.title}");
    return album;
    notifyListeners();
  }

  Future<Album> fetchAlbumProvider(int id) async {
    print("Fetching album....");
    Album album = await ApiService.fetchAlbumApi(id);
    return album;
    notifyListeners();
  }

  Future<Album> deleteAlbumProvider(int id) async {
    print("Deleting.....");
    Album album = await ApiService.deleteAlbumApi(id);
    return album;
    notifyListeners();
  }
}
