import 'dart:convert';

import 'package:evaluacion_app/model/popular_people.dart';
import 'package:evaluacion_app/pages/details_home.dart';
import 'package:evaluacion_app/utils/const.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Results>?> people;
  @override
  void initState() {
    super.initState();
    people = fetchPeople();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(right: 130, top: 80.0),
          child: Text(
            "Popular People List",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ),
        FutureBuilder<List<Results>?>(
          future: people,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _peopleList(snapshot.data!);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const CircularProgressIndicator();
          },
        ),
      ]),
    );
  }
}

Future<List<Results>?> fetchPeople() async {
  final response = await http.get(Uri.parse(
      'https://api.themoviedb.org/3/person/popular?api_key=${API_KEY}&language=en-US&page=1'));
  if (response.statusCode == 200) {
    return PopularResponse.fromJson(jsonDecode(response.body)).results;
  } else {
    throw Exception('Failed to load people');
  }
}

Widget _peopleList(List<Results> peopleList) {
  return SizedBox(
    height: 600,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: peopleList.length,
      itemBuilder: (context, index) {
        return _peopleItem(peopleList.elementAt(index));
      },
    ),
  );
}

Widget _peopleItem(Results results) {
  return Column(children: <Widget>[
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: Image(
          height: 500,
          image: NetworkImage(
              'https://www.themoviedb.org/t/p/original/${results.profilePath}'),
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(right: 100.0),
      child: TextButton(
        onPressed: () {
        //Navigator.push(context, '/details');
      },
        child: Text(results.name.toString(), style: const TextStyle(fontSize: 26, color: Colors.black),),
    )
  )]);
}
