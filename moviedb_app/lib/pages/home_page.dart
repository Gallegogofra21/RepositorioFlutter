import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moviedb_app/models/movie_newest.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const appTittle = 'Starwars';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTittle,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: appTittle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Movie>> movies;

  @override
  void initState() {
    movies = fetchMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Column(children: <Widget>[
        Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 10),
            child: Row(
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(120.0),
                    child: const Image(
                      image: AssetImage('assets/images/Foto1.jpg'),
                      width: 50,
                      height: 50.0,
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    child: const Text(
                      'Erik Howell',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 170.0),
                  child: Container(
                      child: InkWell(
                          onTap: () {
                            debugPrint('Tapped');
                          },
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: Icon(
                              Icons.cast,
                              color: Colors.blue[300],
                            ),
                          ))),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 150.0, top: 40),
          child: Container(
            width: 200,
            child: const Text(
              'Movie, Series, TV Shows...',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 280, top: 20),
          child: Container(
              child: const Text(
            'Newest',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
        ),
        Container(
            margin: EdgeInsets.symmetric(vertical: 180),
            height: 240,
            child: FutureBuilder<List<Movie>>(
              future: movies,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return _moviesList(snapshot.data!);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            ),
          )
        
      ]),
    );
  }
}

Future<List<Movie>> fetchMovies() async {
  final response = await http.get(Uri.parse(
      'https://api.themoviedb.org/3/movie/popular?api_key=715181cb9360e096ec97787869297df1&language=en-US&page=1'));
  if (response.statusCode == 200) {
    return MovieResponse.fromJson(jsonDecode(response.body)).results;
  } else {
    throw Exception('Failed to load movies');
  }
}

Widget _moviesList(List<Movie> moviesList) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: moviesList.length,
    itemBuilder: (context, index) {
      return _movieItem(moviesList.elementAt(index));
    },
  );
}

Widget _movieItem(Movie movie) {
  return Container(
    width: 160,
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      margin: EdgeInsets.all(15),
      elevation: 10,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Column(
          children: <Widget>[
            Image(
                image: NetworkImage(
                    'https://www.themoviedb.org/t/p/original/${movie.posterPath}')),
            Text(movie.title)
          ],
        ),
      ),
    ),
  );
}
