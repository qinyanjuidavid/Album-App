import 'dart:convert';

import 'package:crudapp/models/album_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final String baseUrl = "https://jsonplaceholder.typicode.com/albums";
  static Future getAlbumsApi() async {
    var response = await http.get(
      Uri.parse(baseUrl),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      return data.map((a) => Album.fromJson(a)).toList();
    } else {
      throw Exception("Failed to load album");
    }
  }

  static Future fetchAlbumApi(int id) async {
    var response =
        await http.get(Uri.parse("$baseUrl/$id"), headers: <String, String>{
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return Album.fromJson(data);
    } else {
      throw Exception("Failed to load album");
    }
  }

  static Future updateAlbumApi(String title, int id) async {
    var response = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'title': title,
      }),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("Updated....");
      return Album.fromJson(data);
    } else {
      throw Exception("Failed to update album.");
    }
  }

  static Future createAlbumApi(String title) async {
    final response = await http.post(
      Uri.parse("${baseUrl}"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        <String, String>{
          'title': title,
        },
      ),
    );
    print("Status---> ${response.statusCode}");
    if (response.statusCode == 201) {
      var data = json.decode(response.body);
      print("Created data --->${data}");
      return Album.fromJson(data);
    } else {
      throw Exception("Failed to create album.");
    }
  }

  static Future deleteAlbumApi(int id) async {
    final response = await http.delete(
      Uri.parse("${baseUrl}/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      print("Deleted....");
      return Album.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to delete album.");
    }
  }
}
