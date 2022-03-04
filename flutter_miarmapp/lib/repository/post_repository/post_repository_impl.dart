import 'dart:convert';

import 'package:flutter_miarmapp/models/post.dart';
import 'package:flutter_miarmapp/models/post_dto.dart';
import 'package:flutter_miarmapp/repository/post_repository/post_repository.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostRepositoryImpl extends PostRepository {
  final Client _client = Client();

  @override
  Future<List<Content>> fetchPosts(String type) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print('Prueba token ${token}');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token}'
    };
    final response = await _client
        .get(Uri.parse('http://10.0.2.2:8080/post/public'), headers: headers);
    if (response.statusCode == 200) {
      return PostResponse.fromJson(json.decode(response.body)).content;
    } else {
      throw Exception('Fail to load posts');
    }
  }

  @override
  Future<Content> createPublicacion(PostDto dto, String image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, String> header = {
      'Authorization': 'Bearer ${prefs.getString('token')}',
    };

    var uri = Uri.parse('http://10.0.2.2:8080/post/');
    var request = http.MultipartRequest('POST', uri);
    request.fields['titulo'] = prefs.getString('titulo').toString();
    request.fields['texto'] = prefs.getString('texto').toString();
    request.fields['tipo'] = true.toString();
    request.files.add(await http.MultipartFile.fromPath(
        'file', prefs.getString('file').toString()));
    request.headers.addAll(header);

    var response = await request.send();
    if (response.statusCode == 201) print('Uploaded!');

    if (response.statusCode == 201) {
      return Content.fromJson(
          jsonDecode(await response.stream.bytesToString()));
    } else {
      print(response.statusCode);
      throw Exception(prefs.getString('titulo'));
    }
  }
}
