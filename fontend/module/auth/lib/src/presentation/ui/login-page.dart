import 'package:auth/src/domain/authentication_repository.dart';
import 'package:auth/src/presentation/bloc/auth_bloc.dart';
import 'package:auth/src/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class LoginPage extends StatelessWidget{
  final AuthenticationRepository authenticationRepository;
  const LoginPage({super.key, required this.authenticationRepository});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc,AuthState>(
        builder: (context,state){
          return Text("a");
        },
    );
  }
}