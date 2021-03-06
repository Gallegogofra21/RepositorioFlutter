import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String mensaje;
  final Function retry;

  const ErrorPage({ Key? key, required this.mensaje, required this.retry}) : super (key: key);

  @override 
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      margin: const EdgeInsets.all(4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            mensaje,
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
            onPressed: () => retry,
            child: const Text(
              'Retry'
            )
          )
        ],
      )
    );
  }
}