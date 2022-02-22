import 'package:flutter/cupertino.dart';
import 'package:flutter_miarmapp/repository/post_repository/post_repository.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  late PostRepository postRepository;
}