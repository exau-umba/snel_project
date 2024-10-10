part of 'ajout_compte_snel_bloc.dart';

sealed class AjoutCompteSnelEvent extends Equatable {
  const AjoutCompteSnelEvent();
}

class AddAccountSnel extends AjoutCompteSnelEvent {
  final String label;
  final int clientId;

  AddAccountSnel(this.label, this.clientId);

  @override
  List<Object> get props => [label, clientId];
}

class GetAccountSnel extends AjoutCompteSnelEvent {

  @override
  List<Object> get props => [];
}
