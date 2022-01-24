import 'package:flutter/material.dart';
import 'package:form_app/pages/register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTitle = 'Login';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
          automaticallyImplyLeading: false,
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 100, top: 50, bottom: 20),
            child: const Text(
              'Bienvenido de nuevo!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
              padding: EdgeInsets.only(left: 30, bottom: 20),
              child: const Text(
                'Inicie sesión para continuar usando nuestra app',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.grey),
                textAlign: TextAlign.center,
              )),
          TextFormField(
            decoration: const InputDecoration(
                icon: Icon(Icons.email),
                hintText: 'Introduzca su email',
                labelText: 'Email'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
                icon: Icon(Icons.lock),
                hintText: 'Introduzca su contraseña',
                labelText: 'Password'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 150, top: 30),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')));
                }
              },
              child: const Text('Iniciar sesión'),
            ),
          ),
          Row(children: <Widget>[
            const Padding(
            padding: EdgeInsets.only(left: 70),
            child: Text('¿Aún no estás registrado?',
            style: TextStyle(fontSize: 12),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0.0),
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: const Text('Registrate ahora!'),
            ),)
          ],)
          
        ],
      ),
    );
  }
}
