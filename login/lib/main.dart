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
      title: 'Login',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.

          ),
      home: const MyHomePage(title: 'Beautiful, Private Sharing'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE62F16),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Image(
              image: AssetImage('assets/images/path_logo.png'),
              width: 210,
            ),
            Text(
              'Beautiful, Private Sharing',
              style: TextStyle(
                  color: Colors.white.withOpacity(.5), fontSize: 24.0),
            ),
            Padding(padding: EdgeInsets.only(top: 200)),
            OutlinedButton(
              style: TextButton.styleFrom(
                primary: const Color(0xFFE62F16),
                padding: const EdgeInsets.only(
                    left: 80, right: 80, top: 15, bottom: 15),
                textStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                backgroundColor: Colors.white,
              ),
              onPressed: () {},
              child: const Text('Sign Up'),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            Text(
              'Already have a Path account?',
              style: TextStyle(
                  color: Colors.white.withOpacity(.5), fontSize: 16.0),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            OutlinedButton(
              style: TextButton.styleFrom(
                primary: Colors.white30,
                padding: const EdgeInsets.only(
                    left: 90, right: 90, top: 15, bottom: 15),
                textStyle: const TextStyle(fontSize: 20),
                side: BorderSide(color: Colors.white30, width: 1),
              ),
              onPressed: () {},
              child: const Text('Log In'),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            RichText(
              text: TextSpan(
                text: 'By using Path, you agree to Path`s \n ',
                style: TextStyle(
                  color: Colors.white.withOpacity(.5), fontSize: 14.0),
                children: const <TextSpan>[
                  TextSpan(
                      text: 'Terms of Use',
                      style: TextStyle(color: Colors.white, decoration: TextDecoration.underline)),
                  TextSpan(text: ' and '),
                  TextSpan(text: 'Privacy Policy', style: TextStyle(color: Colors.white, decoration: TextDecoration.underline))
                ],
              ),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
