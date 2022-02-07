import 'dart:convert';
import 'package:intl/date_symbol_data_local.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/onecall_response.dart';

import 'package:weather_app/model/weather_response.dart';

import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  late Future<WeatherResponse> location;
  //late Future<int> hoy;
  //late Future<WeatherResponse> hoy;
  late Future<OneCallResponse> temp;
  late Future<OneCallResponse> date;
  late Future<OneCallResponse> main;
  late Future<OneCallResponse> hourly;

  @override
  void initState() {
    location = fetchLocation();
    temp = _fetchWeather();
    date = _fetchWeather();
    main = _fetchWeather();
    hourly = _fetchWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.black,
            Colors.cyan.shade900,
          ],
        )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(right: 100, top: 80.0),
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
                  )),
              Padding(
                padding: const EdgeInsets.only(right: 70),
                child: FutureBuilder<OneCallResponse>(
                    future: date,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return _getDate(snapshot.data!);
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return const CircularProgressIndicator();
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 140.0, top: 150),
                child: FutureBuilder<OneCallResponse>(
                    future: temp,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return _getTemp(snapshot.data!);
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return const CircularProgressIndicator();
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 140.0),
                child: FutureBuilder<OneCallResponse>(
                    future: main,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return _getMain(snapshot.data!);
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return const CircularProgressIndicator();
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 140.0),
                child: FutureBuilder<OneCallResponse>(
                    future: hourly,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return _getHourly(snapshot.data!);
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return const CircularProgressIndicator();
                    }),
              ),
            ],
          ),
        ));
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
    style: const TextStyle(fontSize: 22, color: Colors.white),
  );
}

Future<OneCallResponse> _fetchWeather() async {
  String apiKey = 'cd7594b90e704bf350b33313dd7e6ff2';
  String lat = '37.36826';
  String lon = '-5.99629';
  var url =
      'https://api.openweathermap.org/data/2.5/onecall?lat=${lat}&lon=${lon}&appid=${apiKey}&lang=es&units=metric';
  var response = await http.get(Uri.parse(url));
  var jsonData = json.decode(response.body);
  return OneCallResponse.fromJson(jsonData);
}

Widget _getDate(OneCallResponse weather) {
  var date =
      DateTime.fromMillisecondsSinceEpoch(weather.current.dt.toInt() * 1000);
  var d24 = DateFormat('MM/dd/yyyy').format(date);
  return Text(
    d24.toString(),
    style: TextStyle(color: Colors.grey.shade400, fontSize: 16),
  );
}

Widget _getTemp(OneCallResponse weather) {
  return Text(weather.current.temp.toString() + 'º',
      style: TextStyle(color: Colors.white, fontSize: 40));
}

Widget _getMain(OneCallResponse weather) {
  return Text(
    weather.current.weather[0].main,
    style: TextStyle(color: Colors.white, fontSize: 26),
  );
}

Widget _getHourly(OneCallResponse weather) {
  return Text(weather.hourly[0].dt.toString());
}
