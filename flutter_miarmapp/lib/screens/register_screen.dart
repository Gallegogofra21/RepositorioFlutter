import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarmapp/bloc/image_pick_bloc/image_pick_bloc.dart';
import 'package:flutter_miarmapp/bloc/image_pick_bloc/image_pick_event.dart';
import 'package:flutter_miarmapp/bloc/image_pick_bloc/image_pick_state.dart';
import 'package:flutter_miarmapp/bloc/register_bloc/register_bloc.dart';
import 'package:flutter_miarmapp/bloc/register_bloc/register_event.dart';
import 'package:flutter_miarmapp/bloc/register_bloc/register_state.dart';
import 'package:flutter_miarmapp/models/register_dto.dart';
import 'package:flutter_miarmapp/models/user.dart';
import 'package:flutter_miarmapp/repository/auth_repository/auth_repository.dart';
import 'package:flutter_miarmapp/repository/auth_repository/auth_repositoryimpl.dart';
import 'package:flutter_miarmapp/screens/login_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:date_field/date_field.dart';

import 'package:file_picker/file_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String imageSelect = "No has seleccionado ninguna imagen";
  FilePickerResult? result;
  PlatformFile? file;

  String date = "";
  DateTime selectedDate = DateTime.now();

  late AuthRepository authRepository;
  final _formKey = GlobalKey<FormState>();
  TextEditingController nick = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController fechaNacimiento = TextEditingController();
  TextEditingController password2 = TextEditingController();
  TextEditingController password = TextEditingController();
  late Future<SharedPreferences> _prefs;
  final String uploadUrl = 'http://10.0.2.2:8080/auth/register';
  String path = "";
  bool _passwordVisible = false;
  bool _password2Visible = false;
  bool isPublic = true;

  @override
  void initState() {
    authRepository = AuthRepositoryImpl();
    _prefs = SharedPreferences.getInstance();
    _passwordVisible = false;
    _password2Visible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return ImagePickBlocBloc();
            },
          ),
          BlocProvider(
            create: (context) {
              return RegisterBloc(authRepository);
            },
          ),
        ],
        child: _createBody(context),
      ),
    );
  }

  _createBody(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: BlocConsumer<RegisterBloc, RegisterState>(
                listenWhen: (context, state) {
              return state is RegisterSuccessState || state is LoginErrorState;
            }, listener: (context, state) async {
              if (state is RegisterSuccessState) {
                _loginSuccess(context, state.registerResponse);
              } else if (state is LoginErrorState) {
                _showSnackbar(context, state.message);
              }
            }, buildWhen: (context, state) {
              return state is RegisterInitial || state is RegisterLoading;
            }, builder: (ctx, state) {
              if (state is RegisterInitial) {
                return _register(ctx);
              } else if (state is RegisterLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return _register(ctx);
              }
            })),
      ),
    );
  }

  Future<void> _loginSuccess(BuildContext context, User late) async {
    _prefs.then((SharedPreferences prefs) {
      prefs.setString('token', late.email);
      prefs.setString('id', late.id);
      prefs.setString('avatar', late.avatar);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _register(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        const SizedBox(
          height: 24,
        ),
        Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.only(bottom: 70),
                  child: Image.asset(
                    'assets/images/logo_miarmapp.png',
                    width: 200,
                    fit: BoxFit.cover,
                  )),
              
              Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: TextFormField(
                    controller: nick,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Nick',
                        labelText: 'Nombre de usuario',
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white))),
                    onSaved: (String? value) {},
                    validator: (String? value) {
                      return (value == null || value.isEmpty)
                          ? 'El campo est?? vac??o.'
                          : null;
                    },
                  )),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: DateTimeFormField(
                  initialDate: DateTime(2001, 9, 7),
                  firstDate: DateTime.utc(1900),
                  lastDate: DateTime.now(),
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.black45),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    suffixIcon: Icon(Icons.event_note),
                    labelText: 'Select Birth Day',
                  ),
                  mode: DateTimeFieldPickerMode.date,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (e) =>
                      (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                  onDateSelected: (DateTime value) {
                    selectedDate = value;
                    print(value);
                  },
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: TextFormField(
                    controller: email,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.email),
                        suffixIconColor: Colors.white,
                        hintText: 'Email',
                        labelText: 'Email',
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white))),
                    onSaved: (String? value) {},
                    validator: (String? value) {
                      return (value == null || !value.contains('@'))
                          ? 'Introduzca un correo v??lido.'
                          : null;
                    },
                  )),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: TextFormField(
                      obscureText: !_passwordVisible,
                      controller: password,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: TextFormField(
                      obscureText: !_password2Visible,
                      controller: password2,
                      decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _password2Visible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _password2Visible = !_password2Visible;
                              });
                            },
                          )),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Checkbox(
                        value: isPublic,
                        onChanged: (value) {
                          setState(() {
                            isPublic = value!;
                          });
                        }),
                  ),
                  const Text('Perfil p??blico'),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: BlocConsumer<ImagePickBlocBloc, ImagePickBlocState>(
                    listenWhen: (context, state) {
                      return state is ImageSelectedSuccessState;
                    },
                    listener: (context, state) {},
                    buildWhen: (context, state) {
                      return state is ImagePickBlocInitial ||
                          state is ImageSelectedSuccessState;
                    },
                    builder: (context, state) {
                      if (state is ImageSelectedSuccessState) {
                        path = state.pickedFile.path;
                        print('PATH ${state.pickedFile.path}');
                        return Column(children: [
                          CircleAvatar(
                            backgroundImage: FileImage(File(path)),
                            radius: 50,
                          ),
                        ]);
                      }
                      return Center(
                          child: ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<ImagePickBlocBloc>(context).add(
                                    const SelectImageEvent(ImageSource.gallery));
                              },
                              child: const Text('Seleccionar avatar')));
                    }),
              )
            ],
          ),
        ),
        
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(240, 50), primary: Colors.blue),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              if (_formKey.currentState!.validate()) {
                final loginDto = RegisterDto(
                    nick: nick.text,
                    fechaNacimiento:
                        DateFormat("yyyy-MM-dd").format(selectedDate),
                    email: email.text,
                    password2: password2.text,
                    password: password.text);

                BlocProvider.of<RegisterBloc>(context)
                    .add(DoRegisterEvent(loginDto, path));
              }
              prefs.setString('nick', nick.text);
              prefs.setString('email', email.text);
              prefs.setString('fechaNacimiento',
                  DateFormat("yyyy-MM-dd").format(selectedDate));
              prefs.setString('password', password.text);
              prefs.setString('password2', password2.text);
              print(path);

              Navigator.pushNamed(context, '/login');
            },
            child: const Text('Registrarse'),
            
          ),
        ),
        Row(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(left: 50),
              child: Text(
                '??Ya tienes una cuenta?',
                style: TextStyle(fontSize: 12),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0.0),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text('Inicia sesi??n!'),
              ),
            )
          ],
        ),
      ]),
    );
  }
}
