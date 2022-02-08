import 'dart:convert';
import 'package:intl/date_symbol_data_local.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/onecall_response.dart';

import 'package:weather_app/model/weather_response.dart';

import 'package:http/http.dart' as http;

class CityPage extends StatefulWidget {
  const CityPage({Key? key}) : super(key: key);

  @override
  State<CityPage> createState() => _MyCityPageState();
}

class _MyCityPageState extends State<CityPage> {
  late Future<WeatherResponse> location;
  late Future<OneCallResponse> temp;
  late Future<OneCallResponse> main;
  late Future<WeatherResponse> tempMax;
  late Future<WeatherResponse> tempMin;

  @override
  void initState() {
    location = fetchLocation();
    temp = _fetchWeather();
    main = _fetchWeather();
    tempMax = fetchLocation();
    tempMin = fetchLocation();
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
            const Padding(
              padding: EdgeInsets.only(top: 70.0, right: 180),
              child: Text(
                "Tus ciudades",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 30),
              child: SizedBox(
                  width: 370,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.grey.shade800,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10))),
                    onPressed: () {},
                    child: Column(children: <Widget>[
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
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
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 228.0, top: 15),
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
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 18.0),
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
                              padding: const EdgeInsets.only(left: 150.0, bottom: 20),
                              child: FutureBuilder<WeatherResponse>(future: tempMax,
                              builder: (context, snapshot) {
                                if(snapshot.hasData) {
                                  return _getTempMax(snapshot.data!);
                                } else if(snapshot.hasError) {
                                  return Text('${snapshot.error}');
                                }
                                return const CircularProgressIndicator();
                              },),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20.0, left: 10),
                              child: FutureBuilder<WeatherResponse>(future: tempMax,
                                builder: (context, snapshot) {
                                  if(snapshot.hasData) {
                                    return _getTempMin(snapshot.data!);
                                  } else if(snapshot.hasError) {
                                    return Text('${snapshot.error}');
                                  }
                                  return const CircularProgressIndicator();
                                },),
                            ),
                          ],
                        ),
                      )
                    ]),
                  )),
            )
          ],
        ),
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
    style: const TextStyle(fontSize: 24, color: Colors.white),
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

Widget _getTemp(OneCallResponse weather) {
  var tempD = weather.current.temp.toInt();
  return Text(tempD.toString() + 'º',
      style: TextStyle(color: Colors.white, fontSize: 26));
}

Widget _getMain(OneCallResponse weather) {
  return Text(
    weather.current.weather[0].main,
    style: TextStyle(color: Colors.grey, fontSize: 18),
  );
}

Widget _getTempMax (WeatherResponse weather) {
  var tempC = weather.main.tempMax - 273.15;
  var tempD = tempC.toInt();
  return Text("Max."+tempD.toString() + 'º', style: TextStyle(color: Colors.grey, fontSize: 18), );
}

Widget _getTempMin (WeatherResponse weather) {
  var tempC = weather.main.tempMin - 273.15;
  var tempD = tempC.toInt();
  return Text("Min."+tempD.toString() + "º", style: TextStyle(color: Colors.grey, fontSize: 18),);
}
