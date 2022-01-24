import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Container(
              child: const Image(
                image: AssetImage('assets/images/Foto1.png'),
                width: 700,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 30),
              child: const Text(
                '¡Bienvenido a TrianaTourist!',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: const Text(
                '¡Inicie sesión para acceder a nuestra App o regístrese si todavía no lo ha hecho!',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      top: 20,
                    ),
                    child: SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: const Text('Login'),
                        )),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: const Text('Registrarse'),
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
