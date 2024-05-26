abstract class AuthSate {}

class AuthInitial extends AuthSate {}

class Authenticating extends AuthSate {}

class Authenticated extends AuthSate {}

class AuthenticationFailed extends AuthSate {
  String? message;
  AuthenticationFailed(this.message);
}

class LoggedOut extends AuthSate{}
