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
  Future<void> logIn({required String username, required String password})
  async{
    // TODO: implement logIn
    final response = await dio.post(
      '/api/login',
      data: {
        'username' : username,
        'password' : password
      }
    );
    return response.data;
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