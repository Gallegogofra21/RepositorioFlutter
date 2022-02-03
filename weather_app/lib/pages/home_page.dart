import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 100.0, right: 270),
          child: Container(child: Text("Feb 3 2022", style: TextStyle(color: Colors.grey.shade400, fontSize: 16),),),
        ),
        Padding(
          padding: const EdgeInsets.only(top:160.0, left: 20),
          child: Container(child: Text("¿Quiere saber si hace buen tiempo para salir a hacer deporte?", textAlign: TextAlign.start, style: TextStyle(fontSize: 20, ),),),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40, right: 50),
          child: Container(child: Text("¡Añade tu ciudad ahora para verlo!", textAlign: TextAlign.start, style: TextStyle(fontSize: 20),),),
        )
      ],)
      /*Container(
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
        ),*/
    );
  }
}