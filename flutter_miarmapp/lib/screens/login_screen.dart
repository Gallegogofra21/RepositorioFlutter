import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarmapp/bloc/login_bloc/login_bloc.dart';
import 'package:flutter_miarmapp/models/auth/login_dto.dart';
import 'package:flutter_miarmapp/repository/auth_repository/auth_repository.dart';
import 'package:flutter_miarmapp/repository/auth_repository/auth_repositoryimpl.dart';
import 'package:flutter_miarmapp/screens/home_screen.dart';
import 'package:flutter_miarmapp/screens/menu_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late Future<SharedPreferences> _prefs;
  late AuthRepository authRepository;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    authRepository = AuthRepositoryImpl();
    _prefs = SharedPreferences.getInstance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return LoginBloc(authRepository);
        },
        child: _createBody(context));
  }

  _createBody(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            
            padding: const EdgeInsets.all(20),
            child: BlocConsumer<LoginBloc, LoginState>(
                listenWhen: (context, state) {
              return state is LoginSuccessState || state is LoginErrorState;
            }, listener: (context, state) {
              if (state is LoginSuccessState) {
                _prefs.then((SharedPreferences prefs) {
                  prefs.setString('token', state.loginResponse.token);
                  print(prefs.getString('token'));
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MenuScreen()),
                  
                );
                });
                
              } else if (state is LoginErrorState) {
                _showSnackbar(context, state.message);
              }
            }, buildWhen: (context, state) {
              return state is LoginInitialState || state is LoginLoadingState;
            }, builder: (ctx, state) {
              if (state is LoginInitialState) {
                return buildForm(ctx);
              } else if (state is LoginLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return buildForm(ctx);
              }
            })),
      ),
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only( top: 150, bottom: 70),
            child: Image.asset('assets/images/logo_miarmapp.png', width: 200, fit: BoxFit.cover,)
          ),
          Padding(padding: const EdgeInsets.only(left: 40, right: 40, bottom: 10),
            child: TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.email),
                  suffixIconColor: Colors.white,
                  hintText: 'Teléfono, usuario o correo electrónico',
                  labelText: 'Email',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white))),
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String? value) {
                return (value == null || !value.contains('@'))
                    ? 'Do not use the @ char.'
                    : null;
              },
            ),
          ),
          Padding(padding: const EdgeInsets.only(left: 40, right: 40),
            child: TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.vpn_key),
                  suffixIconColor: Colors.white,
                  hintText: 'Contraseña',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white))),
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (value) {
                return (value == null || value.isEmpty)
                    ? 'Write a password'
                    : null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(width: 280,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final loginDto = LoginDto(
                      email: emailController.text,
                      password: passwordController.text);
                  BlocProvider.of<LoginBloc>(context).add(DoLoginEvent(loginDto));
                  Navigator.pushNamed(context, '/');
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Processing Data')));
                }
              },
              child:Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: SizedBox(width: 300,
                  child: Text(
                    'Iniciar sesión'.toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),),
            )),
          )),
          Row(children: <Widget>[
            const Padding(
            padding: EdgeInsets.only(left: 50),
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