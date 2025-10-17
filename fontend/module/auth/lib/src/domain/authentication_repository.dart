class User{
  User(this.username,this.password);
  String username;
  String password;
}
enum AuthenticationStatus{unknown,authenticated,unauthenticated}

abstract class AuthenticationRepository{
  Stream<AuthenticationStatus> get status;
  User? get currentUser;
  void dispose();
  Future<void> logIn({
    required String username,
    required String password
  });
  Future<void> logout();
}