abstract class AuthState{}

class AuthInitial extends AuthState{}

// Login states
class AuthLoginSuccess extends AuthState{}
class AuthLoginOnProgress extends AuthState{}
class AuthLoginFailure extends AuthState{}

// Signup states
class AuthRegisterOnProgress extends AuthState{}
class AuthRegisterSuccess extends AuthState{}
class AuthRegisterFailure extends AuthState{}