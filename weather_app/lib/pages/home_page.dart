// ignore_for_file: unnecessary_new

import 'dart:convert';
import 'package:intl/date_symbol_data_local.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/model/onecall_response.dart';

import 'package:weather_app/model/weather_response.dart';

import 'package:http/http.dart' as http;

late double? lat = 0;
  late double? lng;

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
  late Future<List<Hourly>> hourly;
  late Future<List<Daily>> daily;
  late Future<OneCallResponse> icon;

  @override
  void initState() {
    location = fetchLocation();
    temp = _fetchWeather();
    date = _fetchWeather();
    main = _fetchWeather();
    hourly = fetchHourly();
    daily = fetchDaily();
    icon = _fetchWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(lat == 0){
      return Container(
          decoration:  BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.black,
                Colors.cyan.shade900,
              ],
            )
          ),
    child: Scaffold(
      backgroundColor: Colors.transparent,
        body: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 100.0, right: 270),
          child: Text(
            "Feb 3 2022",
            style: TextStyle(color: Colors.grey.shade400, fontSize: 16),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 160.0, left: 20),
          child: Text(
            "??Quiere saber si hace buen tiempo para salir a hacer deporte?",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 40, right: 50),
          child: Text(
            "??A??ade tu ciudad ahora para verlo!",
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 20,
            color: Colors.white,),
          ),
        ),
        
      ],
    )
        /**/
    ));
    }
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
          body: SingleChildScrollView(child: Column(
            children: <Widget>[

              Padding(
                padding: const EdgeInsets.only(left: 15,top: 100.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FutureBuilder<WeatherResponse>(
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
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 270),
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
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 38.0),
                    child: FutureBuilder<OneCallResponse>(
                        future: icon,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return _getIcon(snapshot.data!);
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          return const CircularProgressIndicator();
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 30),
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
                    padding: const EdgeInsets.only(),
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
                ],
              ),
              FutureBuilder<List<Hourly>>(
                  future: hourly,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return _HoursList(snapshot.data!);
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
                  }),
              Divider(
                height: 10,
                thickness: 1,
                indent: 10,
                endIndent: 10,
                color: Colors.grey.shade900.withOpacity(0.3),
              ),
              FutureBuilder<List<Daily>>(
                future: daily,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return _DailyList(snapshot.data!);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        )));
  }
}

Future<WeatherResponse> fetchLocation() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String apiKey = 'cd7594b90e704bf350b33313dd7e6ff2';
  lat = prefs.getDouble('lat');
  lng = prefs.getDouble('lng');
  var url =
      'https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lng}&appid=${apiKey}';
  var response = await http.get(Uri.parse(url));
  var jsonData = json.decode(response.body);
  
  return WeatherResponse.fromJson(jsonData);
}

Widget _getLocation(WeatherResponse weatherResponse) {
  return Text(
    weatherResponse.name,
    style: const TextStyle(fontSize: 22, color: Colors.white),
  );
}

Future<OneCallResponse> _fetchWeather() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String apiKey = 'cd7594b90e704bf350b33313dd7e6ff2';
  lat = prefs.getDouble('lat');
  lng = prefs.getDouble('lng');
  var url =
      'https://api.openweathermap.org/data/2.5/onecall?lat=${lat}&lon=${lng}&appid=${apiKey}&lang=es&units=metric';
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
  var tempD = weather.current.temp.toInt();
  return Text(tempD.toString() + '??',
      style: TextStyle(color: Colors.white, fontSize: 40));
}

Widget _getMain(OneCallResponse weather) {
  return Text(
    weather.current.weather[0].main,
    style: TextStyle(color: Colors.white, fontSize: 26),
  );
}

Widget _getIcon(OneCallResponse weather) {
  var icon = weather.current.weather[0].icon.toString();
  return Container(
      child: Image(
    image: AssetImage('assets/images/${icon}.png'),
    width: 90,
  ));
}

Widget _getHourly(OneCallResponse weather) {
  return Text(weather.hourly[0].dt.toString());
}

Future<List<Hourly>> fetchHourly() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String apiKey = 'cd7594b90e704bf350b33313dd7e6ff2';
  lat = prefs.getDouble('lat');
  lng = prefs.getDouble('lng');
  final response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/onecall?lat=${lat}&lon=${lng}&appid=${apiKey}&lang=es&units=metric'));
  if (response.statusCode == 200) {
    return OneCallResponse.fromJson(jsonDecode(response.body)).hourly;
  } else {
    throw Exception('Failed to load people');
  }
}

Widget _HoursList(List<Hourly> hoursList) {
  return SizedBox(
      height: 170,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: hoursList.length,
        itemBuilder: (context, index) {
          return _HoursItem(hoursList.elementAt(index));
        },
      ));
}

Widget _HoursItem(Hourly hourly) {
  var date = DateTime.fromMillisecondsSinceEpoch(hourly.dt.toInt() * 1000);
  var d24 = DateFormat('hh:mm a').format(date);
  var tempD = hourly.temp.toInt();
  var icon = hourly.weather[0].icon;
  return Column(
    children: [
      SizedBox(
          height: 20,
          width: 80,
          child: Container(
              decoration: const BoxDecoration(
            color: Colors.transparent,
          ))),
      Column(
        children: <Widget>[
          Text(d24.toString(), style: TextStyle(color: Colors.white)),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              width: 40,
              child: Image(
                image: AssetImage('assets/images/${icon}.png'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              tempD.toString() + "??",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    ],
  );
}

Future<List<Daily>> fetchDaily() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String apiKey = 'cd7594b90e704bf350b33313dd7e6ff2';
  lat = prefs.getDouble('lat');
  lng = prefs.getDouble('lng');
  final response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/onecall?lat=${lat}&lon=${lng}&appid=${apiKey}&lang=es&units=metric'));
  if (response.statusCode == 200) {
    return OneCallResponse.fromJson(jsonDecode(response.body)).daily;
  } else {
    throw Exception('Failed to load daily');
  }
}

Widget _DailyList(List<Daily> dailyList) {
  return SizedBox(
      height: 170,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dailyList.length,
        itemBuilder: (context, index) {
          return _DailyItem(dailyList.elementAt(index));
        },
      ));
}

Widget _DailyItem(Daily daily) {
  var date = DateTime.fromMillisecondsSinceEpoch(daily.dt.toInt() * 1000);
  initializeDateFormatting();
  var d24 = DateFormat('EEE', 'ES_es').format(date).toUpperCase();
  var tempD = daily.temp.day.toInt();
  var icon = daily.weather[0].icon;
  return Column(
    children: [
      SizedBox(
          width: 80,
          height: 40,
          child: Container(
              decoration: const BoxDecoration(
            color: Colors.transparent,
          ))),
      Column(
        children: <Widget>[
          Text(d24.toString(), style: TextStyle(color: Colors.white)),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              width: 40,
              child: Image(
                image: AssetImage('assets/images/${icon}.png'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              tempD.toString() + "??",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    ],
  );
}
