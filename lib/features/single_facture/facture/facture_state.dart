part of 'facture_bloc.dart';

sealed class FactureState extends Equatable {
  const FactureState();
}

final class FactureInitial extends FactureState {
  @override
  List<Object> get props => [];
}

class FactureLoading extends FactureState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class FacturesLoaded extends FactureState {
  final List<Facture> factures;

  FacturesLoaded(this.factures);

  @override
  // TODO: implement props
  List<Object?> get props => [factures];
}

class FactureLoaded extends FactureState {
  final Facture facture;

  FactureLoaded(this.facture);

  @override
  // TODO: implement props
  List<Object?> get props => [facture];
}

class FactureError extends FactureState {
  final String message;

  FactureError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
