part of 'ajout_compte_snel_bloc.dart';

sealed class AjoutCompteSnelState extends Equatable {
  const AjoutCompteSnelState();
}

final class AjoutCompteSnelInitial extends AjoutCompteSnelState {
  @override
  List<Object> get props => [];
}

final class AjoutCompteSnelLoading extends AjoutCompteSnelState {

  @override
  List<Object> get props => [];
}

final class AjoutCompteSnelSucces extends AjoutCompteSnelState {
  final String message;
  AjoutCompteSnelSucces(this.message);

  @override
  List<Object> get props => [];
}

final class AjoutCompteSnelError extends AjoutCompteSnelState {
  final String error;
  AjoutCompteSnelError(this.error);

  @override
  List<Object> get props => [error];
}

class AccountSnelLoaded extends AjoutCompteSnelState {
  final List<CompteSnel> accounts;

  AccountSnelLoaded(this.accounts);

  @override
  List<Object> get props => [accounts];
}
