import 'dart:convert';

import 'package:flutter_miarmapp/models/post.dart';
import 'package:flutter_miarmapp/repository/post_repository/post_repository.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostRepositoryImpl extends PostRepository {
  final Client _client = Client();

  @override
  Future<List<Content>> fetchPosts (String type) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print('Prueba token ${token}');

    Map<String, String> headers = {
      'Content-Type': 'application/json', 
      'Authorization' : 'Bearer ${token}'
    };
    final response = await _client.get(Uri.parse('http://10.0.2.2:8080/post/public'), headers: headers);
    if (response.statusCode == 200) {
      return PostResponse.fromJson(json.decode(response.body)).content;
    } else {
      throw Exception('Fail to load posts');
    }
  }
}