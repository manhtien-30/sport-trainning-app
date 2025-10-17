import 'package:auth/src/data/auth_repo_imp.dart';
import 'package:auth/src/domain/authentication_repository.dart';
import 'package:auth/src/presentation/bloc/auth_event.dart';
import 'package:auth/src/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState> {
  final AuthenticationRepository _authenticationRepository;
  AuthBloc({required AuthenticationRepository authenticationRepository})
  : _authenticationRepository = authenticationRepository,
  super(const LoginState()){

  }
}