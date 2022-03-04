import 'package:equatable/equatable.dart';
import 'package:flutter_miarmapp/models/user.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
  
  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}


class RegisterLoading extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  final User registerResponse;

  const RegisterSuccessState(this.registerResponse);

  @override
  List<Object> get props => [registerResponse];
}

class LoginErrorState extends RegisterState {
  final String message;

  const LoginErrorState(this.message);

  @override
  List<Object> get props => [message];
}