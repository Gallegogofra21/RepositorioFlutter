// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';

class HomeEmptyPage extends StatefulWidget {
  const HomeEmptyPage({Key? key}) : super(key: key);

  @override
  State<HomeEmptyPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeEmptyPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            "¿Quiere saber si hace buen tiempo para salir a hacer deporte?",
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
            "¡Añade tu ciudad ahora para verlo!",
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 20,
            color: Colors.white,),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 200.0),
          child: SizedBox(
            width: 300,
            height: 60,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.add, size: 25,),
              style: ElevatedButton.styleFrom(primary: Colors.cyan.shade900.withOpacity(0.3), shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10))),
              label: const Text('Añadir ciudad', style: TextStyle(fontSize: 18),),
              onPressed: () {
              },              
              ),
          ),
        )
      ],
    )
        /**/
    ));
  }
}
