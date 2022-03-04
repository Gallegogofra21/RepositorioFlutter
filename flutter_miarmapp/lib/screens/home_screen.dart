import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarmapp/bloc/posts_bloc/posts_bloc.dart';
import 'package:flutter_miarmapp/bloc/posts_bloc/posts_event.dart';
import 'package:flutter_miarmapp/bloc/posts_bloc/posts_state.dart';
import 'package:flutter_miarmapp/models/auth/login_response.dart';
import 'package:flutter_miarmapp/models/post.dart';
import 'package:flutter_miarmapp/repository/consts.dart';
import 'package:flutter_miarmapp/repository/post_repository/post_repository.dart';
import 'package:flutter_miarmapp/repository/post_repository/post_repository_impl.dart';
import 'package:flutter_miarmapp/ui/widgets/error_page.dart';
import 'package:flutter_miarmapp/widgets/home_app_bar.dart';
import 'package:insta_like_button/insta_like_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return BlocProvider(
        create: (context) {
          return PostsBloc(postRepository)
            ..add(FetchPostWithType(Constant.public));
        },
        child: Scaffold(
          body: _createPublic(context),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(
                Icons.camera_alt,
                size: 20,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            title: const Text(
              "Instagram",
              style: TextStyle(
                  fontFamily: "Genel", fontSize: 30, color: Colors.black),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.add_box_outlined,
                  size: 20,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  Icons.send,
                  size: 20,
                  color: Colors.black,
                ),
                onPressed: () {
                },
              ),
            ],
          ),
          
        ));
  }
}

Widget story(String image, name) {
  return Padding(
    padding: const EdgeInsets.only(right: 12),
    child: Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(0.1),
          width: 76,
          height: 76,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFc05ba6), width: 3)),
          child: ClipOval(
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          name,
          style: TextStyle(
              color: Colors.black.withOpacity(.8), fontWeight: FontWeight.w500),
        )
      ],
    ),
  );
}


Widget _createPublic(BuildContext context) {
  return BlocBuilder<PostsBloc, PostsState>(builder: (context, state) {
    if (state is PostsInitial) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is PostFetchError) {
      return ErrorPage(
        mensaje: state.mensaje,
        retry: () {
          context.watch<PostsBloc>().add(FetchPostWithType('publicos'));
        },
      );
    } else if (state is PostsFetched) {
      return _createPublicView(context, state.posts);
    } else {
      return const Text('Not support');
    }
  });
}

Widget _createPublicView(BuildContext context, List<Content> posts) {
  final contentHeight = 4.0 * (MediaQuery.of(context).size.width / 2.4) / 3;
  return Column(
    children: [
      SizedBox(
        height: 590,
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return _createPublicViewItem(context, posts[index]);
          },
          padding: const EdgeInsets.only(left: 16, right: 16),
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
  String file =
      post.contenidoOriginal.replaceAll('localhost:8080', '10.0.2.2:8080');

  String avatar = post.userAvatar.replaceAll('localhost:8080', '10.0.2.2:8080');

  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.withOpacity(.3)))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(avatar),
          ),
          title: Text(
            post.user,
            style: TextStyle(
                color: Colors.black.withOpacity(.8),
                fontWeight: FontWeight.w400,
                fontSize: 21),
          ),
          trailing: const Icon(Icons.more_vert),
        ),
        Image.network(
          file,
          fit: BoxFit.cover,
          height: 200,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: const <Widget>[
                  Icon(Icons.favorite_border, size: 31),
                  SizedBox(
                    width: 12,
                  ),
                  Icon(Icons.comment_sharp, size: 31),
                  SizedBox(
                    width: 12,
                  ),
                  Icon(Icons.send, size: 31),
                ],
              ),
              const Icon(Icons.bookmark_border, size: 31)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          child: Text(
            'liked by you and 385 others',
            style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(.8)),
          ),
        )
      ],
    ),
  );
}
