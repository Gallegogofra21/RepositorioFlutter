import 'package:flutter/material.dart';
import 'package:weather_app/pages/details_page.dart';
import 'package:weather_app/pages/home_empty_page.dart';

import 'package:weather_app/pages/home_page.dart';
import 'package:weather_app/pages/map.dart';
import 'package:weather_app/pages/menu_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      initialRoute: '/menu',
      routes: {
        '/menu': (context) => const MenuPage(),
        '/home': (context) => const HomePage(),
        '/home_empty': (context) => const HomeEmptyPage(),
        '/details': (context) => const DetailsPage(),
        '/map': (context) => const MapClickPage()
      },
    );
  }
}
