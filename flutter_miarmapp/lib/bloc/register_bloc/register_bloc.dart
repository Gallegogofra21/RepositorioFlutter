import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarmapp/bloc/register_bloc/register_event.dart';
import 'package:flutter_miarmapp/bloc/register_bloc/register_state.dart';
import 'package:flutter_miarmapp/repository/auth_repository/auth_repository.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;

  RegisterBloc(this.authRepository) : super(RegisterInitial()) {
    on<DoRegisterEvent>(_doRegisterEvent);
  }

void _doRegisterEvent(DoRegisterEvent event, Emitter<RegisterState> emit) async {
    try {
      final loginResponse = await authRepository.register(event.registerDto, event.image);
      emit(RegisterSuccessState(loginResponse));
      return;
    } on Exception catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }


}