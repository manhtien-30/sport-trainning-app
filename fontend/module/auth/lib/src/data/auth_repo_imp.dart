import 'package:auth/src/domain/authentication_repository.dart';

class AuthenticationRepositoryImp extends AuthenticationRepository{
  @override
  // TODO: implement currentUser
  User? get currentUser => throw UnimplementedError();

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  Future<void> logIn({required String username, required String password}) {
    // TODO: implement logIn
    throw UnimplementedError();
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