import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}
class OnUsernameChanged extends AuthEvent{

}
class AuthenticationLogInRequest extends AuthEvent{

}