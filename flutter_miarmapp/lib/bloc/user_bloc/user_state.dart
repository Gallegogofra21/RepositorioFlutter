import 'package:equatable/equatable.dart';
import 'package:flutter_miarmapp/models/user.dart';

abstract class UserState extends Equatable {
  const UserState();
  
  @override
  List<Object> get props => [];
}

class UserWithPostInitial extends UserState {}

class UsersFetched extends UserState {
  final User users;
  final String type;

  const UsersFetched(this.users, this.type);

  @override
  List<Object> get props => [users];
}

class UserFetchedError extends UserState {
  final String message;
  const UserFetchedError(this.message);

  @override
  List<Object> get props => [message];
}