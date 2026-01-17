import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class AuthLoginStarted extends AuthEvent{
  String username;
  String password;
  AuthLoginStarted(this.username,this.password);
}

class AuthRegisterStarted extends AuthEvent{
  final String username;
  final String password;
  final String email;
  AuthRegisterStarted(this.username, this.password, this.email);
  @override
  List<Object?> get props => [username, password, email];
}