import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarmapp/bloc/posts_bloc/posts_bloc.dart';
import 'package:flutter_miarmapp/bloc/posts_bloc/posts_event.dart';
import 'package:flutter_miarmapp/bloc/posts_bloc/posts_state.dart';
import 'package:flutter_miarmapp/models/post.dart';
import 'package:flutter_miarmapp/repository/post_repository/post_repository.dart';
import 'package:flutter_miarmapp/repository/post_repository/post_repository_impl.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  late PostRepository postRepository;

  @override
  void initState() {
    super.initState();
    postRepository = PostRepositoryImpl();
  }

  @override 
  void dispose() {
    super.dispose();
  }

  @override 
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) { return PostsBloc(postRepository)..add(FetchPostWithType(Constant.popular));},
    child: Scaffold(body: _createPublic(context)),
    );
  }

  Widget _createPublic (BuildContext context) {
    return BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        if(state is PostsInitial){
        return const Center(child: CircularProgressIndicator()); 
      } else if(state is PostFetchError){
        return ErrorPage(
          mensaje: state.mensaje,
          retry: () {
            context.watch<PostsBloc>().add(FetchPostWithType('publicos'));
          },
        );
      }else if(state is PostsFetched) {
        return _createPublicView(context, state.posts);
      }else {
        return const Text('Not support');
      }
      }
    );
  }

  Widget _createPublicView(BuildContext context, List<Content> posts) {
    final contentHeight = 4.0 * (MediaQuery.of(context).size.width / 2.4) / 3;
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 20.0, right: 16),
          height: 48.0,
          child: Row(
            children: const [
              Expanded(flex: 1,
              child: Text(
                'Public',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16.0,
                  fontFamily: 'Muli',
                  fontWeight: FontWeight.bold,
                ),
              ),),
              const Icon(Icons.arrow_forward, color: Colors.red),
            ],
          ),
        ),
        SizedBox(
          height: contentHeight,
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return _createPublicViewItem(context, posts[index]);
            },
            padding: const EdgeInsets.only(left: 16, right: 16),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const VerticalDivider(
              color: Colors.transparent,
              width: 6.0,
            ),
            itemCount: posts.length,
          ),
        )
      ],
    );
  }

  Widget _createPublicViewItem(BuildContext context, Content post) {
    final width = MediaQuery.of(context).size.width / 2.6;
    return Container(
      width: width,
      height: double.infinity,
      padding: const EdgeInsets.only(bottom: 20),
      child: Card(
        elevation: 10,
        borderOnForeground: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
        ),
        child: SizedBox(
          width: width,
          height: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              imageUrl: 'localhost:8080/',
            ),
          ),
        ),
      )
    )
  }
}