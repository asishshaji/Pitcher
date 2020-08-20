part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppLoaded extends AuthenticationEvent {}

class UserLoginPressed extends AuthenticationEvent {}

class UserLoggedOut extends AuthenticationEvent {}
