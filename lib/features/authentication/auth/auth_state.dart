part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
}

final class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AuthAuthenticated extends AuthState {
  final String email;

  const AuthAuthenticated(this.email);

  @override
  // TODO: implement props
  List<Object?> get props => [email];

}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

