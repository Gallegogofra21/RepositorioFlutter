import 'dart:convert';

import 'package:flutter_miarmapp/models/post.dart';
import 'package:flutter_miarmapp/repository/post_repository/post_repository.dart';
import 'package:http/http.dart';

class PostRepositoryImpl extends PostRepository {
  final Client _client = Client();

  @override
  Future<List<Content>> fetchPosts (String type) async {
    final response = await _client.get(Uri.parse('http://localhost:8080/post/public'));
    if (response.statusCode == 200) {
      return PostResponse.fromJson(json.decode(response.body)).content;
    } else {
      throw Exception('Fail to load posts');
    }
  }
}