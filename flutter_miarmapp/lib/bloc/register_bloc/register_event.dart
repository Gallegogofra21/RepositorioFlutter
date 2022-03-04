import 'package:equatable/equatable.dart';
import 'package:flutter_miarmapp/models/register_dto.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class DoRegisterEvent extends RegisterEvent {
  final RegisterDto registerDto;
  final String image;

  const DoRegisterEvent(this.registerDto, this.image);
}