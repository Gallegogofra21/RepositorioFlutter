import 'dart:convert';
import 'package:intl/date_symbol_data_local.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/onecall_response.dart';

import 'package:weather_app/model/weather_response.dart';

import 'package:http/http.dart' as http;

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DetailsPage> {
  late Future<WeatherResponse> location;
  //late Future<int> hoy;
  //late Future<WeatherResponse> hoy;
  late Future<OneCallResponse> temp;
  late Future<OneCallResponse> date;
  late Future<OneCallResponse> main;
  late Future<OneCallResponse> icon;
  late Future<WeatherResponse> tempMax;
  late Future<WeatherResponse> tempMin;
  late Future<OneCallResponse> uvi;
  late Future<OneCallResponse> feelsLike;
  late Future<OneCallResponse> pressure;

  @override
  void initState() {
    location = fetchLocation();
    temp = _fetchWeather();
    date = _fetchWeather();
    main = _fetchWeather();
    icon = _fetchWeather();
    tempMax = fetchLocation();
    tempMin = fetchLocation();
    uvi = _fetchWeather();
    feelsLike = _fetchWeather();
    pressure = _fetchWeather();
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
            body: Column(children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(right: 295, top: 80.0),
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
              Row(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 20),
                  child: SizedBox(
                      width: 150,
                      height: 120,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.grey.shade200.withOpacity(0.2),
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20))),
                        onPressed: () {},
                        child: Column(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 10, right: 50),
                            child: Text(
                              "MIN TEMP",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, right: 75),
                            child: FutureBuilder<WeatherResponse>(
                              future: tempMax,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return _getTempMin(snapshot.data!);
                                } else if (snapshot.hasError) {
                                  return Text('${snapshot.error}');
                                }
                                return const CircularProgressIndicator();
                              },
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 5, right: 70),
                            child: Text(
                              "Min",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 26),
                            ),
                          ),
                        ]),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, top: 30),
                  child: SizedBox(
                      width: 150,
                      height: 120,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.grey.shade200.withOpacity(0.2),
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20))),
                        onPressed: () {},
                        child: Column(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 10, right: 40),
                            child: Text(
                              "MAX TEMP",
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, right: 75),
                            child: FutureBuilder<WeatherResponse>(
                              future: tempMax,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return _getTempMax(snapshot.data!);
                                } else if (snapshot.hasError) {
                                  return Text('${snapshot.error}');
                                }
                                return const CircularProgressIndicator();
                              },
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 5, right: 65),
                            child: Text(
                              "Max",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 26),
                            ),
                          )
                        ]),
                      )),
                )
              ]),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 28.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 20),
                          child: SizedBox(
                              width: 150,
                              height: 180,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary:
                                        Colors.grey.shade200.withOpacity(0.2),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(20))),
                                onPressed: () {},
                                child: Column(children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, right: 40),
                                    child: Text(
                                      "Uv Indicator",
                                      style: TextStyle(
                                          color: Colors.grey.shade600),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, right: 65),
                                    child: FutureBuilder<OneCallResponse>(
                                      future: uvi,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return _getUv(snapshot.data!);
                                        } else if (snapshot.hasError) {
                                          return Text('${snapshot.error}');
                                        }
                                        return const CircularProgressIndicator();
                                      },
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 5, right: 65),
                                    child: Text(
                                      "Low",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 26),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 18.0),
                                    child:
                                        Text("Low level during all the day."),
                                  )
                                ]),
                              )),
                        ),
                      ],
                    ),
                  ),
                  Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0, top: 35),
                      child: SizedBox(
                          width: 150,
                          height: 70,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.grey.shade200.withOpacity(0.2),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(20))),
                            onPressed: () {},
                            child: Column(children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, right: 40),
                                child: Text(
                                  "FEELS LIKE",
                                  style: TextStyle(color: Colors.grey.shade600),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, right: 65),
                                child: FutureBuilder<OneCallResponse>(
                                  future: feelsLike,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return _getFeelsLike(snapshot.data!);
                                    } else if (snapshot.hasError) {
                                      return Text('${snapshot.error}');
                                    }
                                    return const CircularProgressIndicator();
                                  },
                                ),
                              ),
                            ]),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0, top: 50),
                      child: SizedBox(
                          width: 150,
                          height: 70,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.grey.shade200.withOpacity(0.2),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(20))),
                            onPressed: () {},
                            child: Column(children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, right: 40),
                                child: Text(
                                  "PRESSURE",
                                  style: TextStyle(color: Colors.grey.shade600),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, right: 5),
                                child: FutureBuilder<OneCallResponse>(
                                  future: pressure,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return _getPressure(snapshot.data!);
                                    } else if (snapshot.hasError) {
                                      return Text('${snapshot.error}');
                                    }
                                    return const CircularProgressIndicator();
                                  },
                                ),
                              ),
                            ]),
                          )),
                    )
                  ])
                ],
              )
            ])));
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
  return Text(tempD.toString() + 'º',
      style: TextStyle(color: Colors.white, fontSize: 24));
}

Widget _getMain(OneCallResponse weather) {
  return Text(
    weather.current.weather[0].main,
    style: TextStyle(color: Colors.grey, fontSize: 18),
  );
}

Widget _getTempMax(WeatherResponse weather) {
  var tempC = weather.main.tempMax - 273.15;
  var tempD = tempC.toInt();
  return Text(
    tempD.toString() + 'º',
    style: TextStyle(color: Colors.white, fontSize: 26),
  );
}

Widget _getTempMin(WeatherResponse weather) {
  var tempC = weather.main.tempMin - 273.15;
  var tempD = tempC.toInt();
  return Text(
    tempD.toString() + "º",
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

Widget _getUv(OneCallResponse weather) {
  return Text(
    weather.current.uvi.toString(),
    style: TextStyle(color: Colors.white, fontSize: 26),
  );
}

Widget _getFeelsLike(OneCallResponse weather) {
  var int = weather.current.feelsLike.toInt();
  return Text(int.toString() + "º",
      style: TextStyle(color: Colors.white, fontSize: 26));
}

Widget _getPressure(OneCallResponse weather) {
  return Text(weather.current.pressure.toString() + " hPa",
      style: TextStyle(color: Colors.white, fontSize: 26));
}
