import 'dart:convert';

import 'package:digimonapp/models/players_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PlayerPage extends StatelessWidget {
  const PlayerPage({Key? key}) : super(key: key);

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
      home: const PlayerHomePage(title: appTittle),
    );
  }
}

class PlayerHomePage extends StatefulWidget {
  const PlayerHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<PlayerHomePage> createState() => _PlayerPage();
}

class _PlayerPage extends State<PlayerHomePage> {
  late Future<List<Agent>> agentes;

  @override
  void initState() {
    agentes = fetchAgentes();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jugadores')),
      body: Container(
                      margin: EdgeInsets.symmetric(vertical: 180.0),
                      height: 240,
                      child: FutureBuilder<List<Agent>>(
                        future: agentes,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return _jugadoresList(snapshot.data!);
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }

                          return const CircularProgressIndicator();
                        },
                      )),
    );
  }

  Future<List<Agent>> fetchAgentes() async {
    final response = await http.get(Uri.parse('https://swapi.dev/api/people'));
    if (response.statusCode == 200) {
      return AgentResponse.fromJson(jsonDecode(response.body)).results;
    } else {
      throw Exception('Failed to load people');
    }
  }

  Widget _jugadoresList(List<Agent> jugadoresList) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: jugadoresList.length,
      itemBuilder: (context, index) {
        return _jugadoresItem(jugadoresList.elementAt(index));
      },
    );
  }

  Widget _jugadoresItem(Agent agent) {
    //List<String> urlFoto = player.url.split('/');
    //String numFoto = urlFoto[5];
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
              /*Image(
                  image: NetworkImage(
                      'https://starwars-visualguide.com/assets/img/characters/${numFoto}.jpg')),*/
              Text(agent.displayName)
            ],
          ),
        ),
      ),
    );
  }
  }

