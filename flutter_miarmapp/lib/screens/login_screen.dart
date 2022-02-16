import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
     return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 100, top: 150, bottom: 70),
            child: Image.asset('assets/images/logo_miarmapp.png', width: 200, fit: BoxFit.cover,)
          ),
          Padding(
            padding: const EdgeInsets.only(left:40.0, right: 40, bottom: 10),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                  hintText: 'Teléfono, usuario o correo electrónico',
                  labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:40.0, right: 40.0),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                  hintText: 'Contraseña',
                  labelText: 'Password'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, top: 10),
            child: SizedBox(
              width: 320,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')));
                }
              },
              child: const Text('Iniciar sesión'),
            ),
          )
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