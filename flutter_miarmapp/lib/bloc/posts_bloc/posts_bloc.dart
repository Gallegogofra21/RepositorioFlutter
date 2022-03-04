import 'package:flutter_miarmapp/bloc/posts_bloc/posts_event.dart';
import 'package:flutter_miarmapp/bloc/posts_bloc/posts_state.dart';
import 'package:flutter_miarmapp/repository/post_repository/post_repository.dart';
import 'package:bloc/bloc.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostRepository postRepository;

  PostsBloc(this.postRepository) : super(PostsInitial()) {
    on<FetchPostWithType>(_postsFetched);
  }

  void _postsFetched(FetchPostWithType event, Emitter<PostsState> emit) async {
    try {
      final posts = await postRepository.fetchPosts(event.type);
      emit(PostsFetched(posts, event.type));
      return;
    } on Exception catch (e) {
      emit(PostFetchError(e.toString()));
    }
  }
}