import 'package:auth/src/domain/authentication_repository.dart';
import 'package:auth/src/presentation/bloc/auth_event.dart';
import 'package:auth/src/presentation/bloc/auth_state.dart';
import 'package:bloc/bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  AuthBloc(this.authenticationRepository) : super(AuthInitial() ){
    on<AuthLoginStarted>(_onLoginStarted);
    on<AuthRegisterStarted>(_onRegisterStared);
  }
  final AuthenticationRepository authenticationRepository;
  Future<void> _onLoginStarted(AuthLoginStarted event, Emitter<AuthState> emit) async {
    emit(AuthLoginOnProgress());
    final isLoggedIn = await authenticationRepository.signIn(username: event.username, password: event.password);

    if(isLoggedIn == true){
      emit(AuthLoginSuccess());
    } else {
      emit(AuthLoginFailure());
    }
  }

  Future<void> _onRegisterStared(AuthRegisterStarted event, Emitter<AuthState> emit) async {
    emit(AuthRegisterOnProgress());
    final isSignedUp = await authenticationRepository.signUp(
      username: event.username,
      password: event.password,
      email: event.email,
    );

    if (isSignedUp == true) {
      emit(AuthRegisterSuccess());
    } else {
      emit(AuthRegisterFailure());
    }
  }
}