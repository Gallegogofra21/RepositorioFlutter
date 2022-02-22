import 'package:equatable/equatable.dart';
import 'package:flutter_miarmapp/models/post.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override 
  List<Object> get props => [];
}

class PostsInitial extends PostsState{}

class PostsFetched extends PostsState {
  final List<Content> posts;
  final String type;

  const PostsFetched(this.posts, this.type);

  @override 
  List<Object> get props => [posts];
}

class PostFetchError extends PostsState {
  final String mensaje;
  const PostFetchError(this.mensaje);

  @override
  List<Object> get props => [mensaje];
}