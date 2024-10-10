part of 'facture_bloc.dart';

sealed class FactureEvent extends Equatable {
  const FactureEvent();
}

class FetchFactures extends FactureEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchFacture extends FactureEvent {
  final Facture facture;

  FetchFacture(this.facture);

  @override
  // TODO: implement props
  List<Object?> get props => [facture];
}
