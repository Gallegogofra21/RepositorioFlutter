import 'package:flutter/material.dart';
import 'package:flutter_post_request/pages/login_page.dart';
import 'package:flutter_post_request/pages/register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
      },
      title: 'Minitwitter',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: const LoginPage(),
    );
  }
}
