abstract class AuthEvent {}

class AuthLoginRequested extends AuthEvent {
  AuthLoginRequested({required this.email, required this.password});

  final String email;
  final String password;
}

class AuthRegisterRequested extends AuthEvent {
  AuthRegisterRequested({required this.email, required this.password});

  final String email;
  final String password;
}

class AuthLogoutRequested extends AuthEvent {}
