import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if( event is SignInRequested){
        emit(AuthLoading());
        await Future.delayed(Duration(seconds: 1));
        if (event.email == "snel@gmail.com" && event.password == "password123") {
          emit(AuthAuthenticated(event.email));
        } else {
          emit(AuthError("Erreur: Identifiants incorrects."));
        }
      }else if (event is SignUpRequested) {
        emit (AuthLoading());
        await Future.delayed(Duration(seconds: 1)); // Simulate sign-up process
        emit (AuthAuthenticated(event.email));
      } else if (event is AuthSignOutRequested) {
        emit (AuthInitial());
      }
    });
  }
}
