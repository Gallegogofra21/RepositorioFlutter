import 'package:flutter_miarmapp/models/post.dart';

abstract class PostRepository {
  Future<List<Content>> fetchPosts(String type);
}