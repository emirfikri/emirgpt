import 'package:emirgpt/models/user.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

// Register States
class AuthRegistering extends AuthState {
  const AuthRegistering();
}

class AuthRegistered extends AuthState {
  final User user;

  const AuthRegistered(this.user);
}

// Login States
class AuthLoggingIn extends AuthState {
  const AuthLoggingIn();
}

class AuthLoggedIn extends AuthState {
  final User user;

  const AuthLoggedIn(this.user);
}

// Logout State
class AuthLoggedOut extends AuthState {
  const AuthLoggedOut();
}

// Forgot Password States
class AuthForgotPasswordSending extends AuthState {
  const AuthForgotPasswordSending();
}

class AuthForgotPasswordSent extends AuthState {
  final String email;

  const AuthForgotPasswordSent(this.email);
}

// Error State
class AuthError extends AuthState {
  final String message;
  final String? code;

  const AuthError(this.message, {this.code});
}
