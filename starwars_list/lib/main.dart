import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:starwars_list/models/planet_response.dart';
import 'models/people_response.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  late Future<List<People>> personajes;

  late Future<List<Planet>> planetas;

  @override
  void initState() {
    personajes = fetchPersonajes();
    planetas = fetchPlanetas();
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
    return MaterialApp(
        home: DefaultTabController(
            length: 2,
            child: Scaffold(
                appBar: AppBar(
                  bottom: const TabBar(
                    tabs: [
                      Tab(icon: Icon(Icons.person)),
                      Tab(icon: Icon(Icons.language)),
                    ],
                  ),
                  title: const Text('Starwars'),
                ),
                body: TabBarView(children: <Widget>[
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 180.0),
                      height: 240,
                      child: FutureBuilder<List<People>>(
                        future: personajes,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return _personajesList(snapshot.data!);
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }

                          return const CircularProgressIndicator();
                        },
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 180.0),
                      height: 200,
                      child: FutureBuilder<List<Planet>>(
                        future: planetas,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return _planetsList(snapshot.data!);
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }

                          return const CircularProgressIndicator();
                        },
                      )),
                ]))));
  }

  Future<List<People>> fetchPersonajes() async {
    final response = await http.get(Uri.parse('https://swapi.dev/api/people'));
    if (response.statusCode == 200) {
      return PeopleResponse.fromJson(jsonDecode(response.body)).results;
    } else {
      throw Exception('Failed to load people');
    }
  }

  Widget _personajesList(List<People> personajesList) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: personajesList.length,
      itemBuilder: (context, index) {
        return _personajesItem(personajesList.elementAt(index));
      },
    );
  }

  Widget _personajesItem(People people) {
    List<String> urlFoto = people.url.split('/');
    String numFoto = urlFoto[5];
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
                      'https://starwars-visualguide.com/assets/img/characters/${numFoto}.jpg')),
              Text(people.name)
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Planet>> fetchPlanetas() async {
    final response = await http.get(Uri.parse('https://swapi.dev/api/planets'));
    if (response.statusCode == 200) {
      return PlanetResponse.fromJson(jsonDecode(response.body)).results;
    } else {
      throw Exception('Failed to load planets');
    }
  }

  Widget _planetsList(List<Planet> planetsList) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: planetsList.length,
      itemBuilder: (context, index) {
        return _planetsItem(planetsList.elementAt(index));
      },
    );
  }

  Widget _planetsItem(Planet planet) {
    List<String> urlFoto = planet.url.split('/');
    String numFoto = urlFoto[5];
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
                      'https://starwars-visualguide.com/assets/img/planets/${numFoto}.jpg')),
              Text(planet.name)
            ],
          ),
        ),
      ),
    );
  }
}
