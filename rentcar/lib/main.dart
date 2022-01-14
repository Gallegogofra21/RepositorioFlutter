import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rentcar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Rentcar'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Card(
              child: InkWell(
                  splashColor: Colors.blue.withAlpha(50),
                  onTap: () {
                    debugPrint('Card tapped.');
                  },
                  child: SizedBox(
                    width: 400,
                    height: 350,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              child: const Text(
                                'El más barato, Buena puntuación',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 100),
                              child: const Text(
                                '45 ofertas',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                            child: const Image(
                          image: AssetImage('assets/images/foto1.PNG'),
                          width: 300,
                        )),
                        Container(
                          padding: EdgeInsets.only(right: 300),
                          child: const Text(
                            'Range Rover',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 170),
                          child: const Text(
                            '2-3 puertas · Range Rover Evoque',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Row(
                          children: const <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Image(
                                image: AssetImage('assets/images/foto2.PNG'),
                                width: 15,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Text('Auto.'),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.ac_unit,
                                size: 16,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Text('A/A'),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.person, size: 18),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Text('Los que quepan'),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.home_repair_service, size: 16),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Text('1'),
                            )
                          ],
                        ),
                        const Divider(
                          height: 20,
                          thickness: 1,
                          indent: 16,
                          endIndent: 10,
                          color: Colors.grey,
                        ),
                        Row(
                          children: <Widget>[
                            TextButton(
                              child: const Text('35€'),
                              onPressed: () {},
                            ),
                            const SizedBox(width: 8),
                            Padding(
                              padding: const EdgeInsets.only(left: 200),
                              child: TextButton(
                                child: const Text('SELECCIONAR'),
                                onPressed: () {},
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ))),
        ));
  }
}
