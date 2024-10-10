part of 'payment_bloc.dart';

sealed class PaymentEvent extends Equatable {
  const PaymentEvent();
}


class AddMobilePayment extends PaymentEvent {
  final String numero;
  final String devise;
  final int idClient; // Référence à l'ID du client

  AddMobilePayment( {required this.numero, required this.idClient,required this.devise,});

  @override
  // TODO: implement props
  List<Object?> get props => [devise, numero,idClient ];
}

class AddCardPayment extends PaymentEvent {
  final String numero; // Numéro de la carte
  final int idClient; // Référence à l'ID du client
  final String cvv;
  final String date;
  final String nom;

  AddCardPayment({required this.numero, required this.idClient, required this.cvv, required this.date, required this.nom, });

  @override
  // TODO: implement props
  List<Object?> get props => [numero, cvv, nom, date, idClient];
}

class GetMobilePayments extends PaymentEvent {
  final int idClient; // Référence à l'ID du client

  GetMobilePayments({required this.idClient});

  @override
  // TODO: implement props
  List<Object?> get props => [idClient];
}

class GetCardPayments extends PaymentEvent {
  final int idClient; // Référence à l'ID du client

  GetCardPayments({required this.idClient});

  @override
  // TODO: implement props
  List<Object?> get props => [idClient];
}

class GetPaymentsMethode extends PaymentEvent {
  @override
  List<Object?> get props => [];
}

class ShuffleList extends PaymentEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}