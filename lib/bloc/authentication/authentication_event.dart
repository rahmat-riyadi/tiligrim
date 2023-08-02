part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationSubmit extends AuthenticationEvent {}

class AuthenticationCheck extends AuthenticationEvent {}

class AuthenicationSignOut extends AuthenticationEvent {}
