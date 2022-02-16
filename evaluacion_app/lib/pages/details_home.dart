import 'dart:convert';

import 'package:evaluacion_app/model/popular_people.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:evaluacion_app/utils/const.dart';

class DetailsHome extends StatefulWidget {
  const DetailsHome({Key? key}) : super(key: key);

  @override
  State<DetailsHome> createState() => _HomePageState();
}

class _HomePageState extends State<DetailsHome> {
  late Future<List<Results>?> people;
  @override
  void initState() {
    super.initState();
    //people = fetchPeople();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(""))),
      )
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

Widget _movieList(List<Results> peoplelist) {
  return SizedBox(
    child: ListView.builder(scrollDirection: Axis.horizontal,
    itemCount: peoplelist.length,
    itemBuilder: (context, index) {
      return _movieItem(peoplelist.elementAt(index));
    },),
  );
}

Widget _movieItem(Results results) {
  return Column(children: <Widget>[
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: Image(
          height: 500,
          image: NetworkImage(
              'https://www.themoviedb.org/t/p/original/${results.knownFor![0].posterPath}'),
        ),
      ),
    )]);
}