import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarmapp/bloc/user_bloc/user_event.dart';
import 'package:flutter_miarmapp/bloc/user_bloc/user_state.dart';
import 'package:flutter_miarmapp/repository/user_repository/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
    final UserRepository public;

  UserBloc(this.public) : super(UserWithPostInitial()) {
    on<FetchUserWithType>(_publicacionesFetched);
}

void _publicacionesFetched(FetchUserWithType event, Emitter<UserState> emit) async {
    try {
      final movies = await public.fetchUsers(event.type);
      emit(UsersFetched(movies, event.type));
      return;
    } on Exception catch (e) {
      emit(UserFetchedError(e.toString()));
    }
  }
}