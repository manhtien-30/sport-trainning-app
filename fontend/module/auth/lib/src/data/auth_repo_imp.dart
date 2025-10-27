import 'package:auth/src/domain/authentication_repository.dart';
import 'package:dio/dio.dart';

class AuthenticationRepositoryImp extends AuthenticationRepository{
  final Dio dio = Dio();
  @override
  // TODO: implement currentUser
  User? get currentUser => throw UnimplementedError();

  @override
  void dispose() {
    // TODO: implement dispose

  }

  @override
  Future<bool> logIn({required String username, required String password})
  async{
    return true;
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  // TODO: implement status
  Stream<AuthenticationStatus> get status => throw UnimplementedError();

}