import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/model/earth_weather_response.dart';
import 'package:weather_app/model/weather_response.dart';

import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  late Future<WeatherResponse> location;
  late Future<Current> dt;

  @override
  void initState() {
    location = fetchLocation();
    dt = fetchDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(top: 80.0, left: 20),
              child: Container(
                  child: FutureBuilder<WeatherResponse>(
                future: location,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return _getLocation(snapshot.data!);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                },
              ))),
          Container(
            child: FutureBuilder<Current>(
              future: dt,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return _getDateTime(snapshot.data!);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            ),
          )
        ],
      ),
    );
  }
}

Future<WeatherResponse> fetchLocation() async {
  final response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=37.3789818&lon=-6.0174968&appid=9f277403fbc997f9a305df9b742acda7'));
  if (response.statusCode == 200) {
    return WeatherResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load location');
  }
}

Widget _getLocation(WeatherResponse weatherResponse) {
  return Text(
    weatherResponse.name,
    style: TextStyle(fontSize: 22),
  );
}

Future<Current> fetchDate() async {
  final response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/onecall?lat=37.3789818&lon=-6.0174968&exclude=minutely&appid=9f277403fbc997f9a305df9b742acda7'));
  if (response.statusCode == 200) {
    return Current.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load dt');
  }
}

Widget _getDateTime(Current current) {
  DateTime.fromMillisecondsSinceEpoch(current.dt * 1000);
  return Text('${current.dt}');
}
