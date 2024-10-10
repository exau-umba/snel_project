part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
}


class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested({this.email="snel@gmail.com", this.password="password123"});

  @override
  // TODO: implement props
  List<Object?> get props => [email, password];
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String nomComplet;
  final String password;

  SignUpRequested({this.email="snel@gmail.com", this.password="password123", this.nomComplet="Agent"});

  @override
  // TODO: implement props
  List<Object?> get props => [email, password, nomComplet];
}

class AuthSignOutRequested extends AuthEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
