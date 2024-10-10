import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snel_project/data/models/payement_card.dart';
import 'package:snel_project/data/models/payement_mobile.dart';

import '../../../data/dataBrut.dart';
import '../../../data/services/database_helper.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final DatabaseHelper databaseHelper;
  PaymentBloc(this.databaseHelper) : super(PaymentInitial()) {
    on<PaymentEvent>((event, emit) async {
      if (event is AddMobilePayment) {
        emit (PaymentLoading());
        try {
          final payment = PaymentMobile(devise: event.devise, idClient: event.idClient, numero: event.numero);
          await databaseHelper.insertMobilePayment(payment);
          emit (AjoutMobilePaymentsSucces('Mode de paiement mobile ajouté avec succès !'));
        } catch (e) {
          emit (AjoutMobilePaymentsError('Échec de l\'ajout du mode de paiement mobile'));
        }
      } else if (event is AddCardPayment) {
        emit (PaymentLoading());
        try {
          final payment = PaymentCard(numero: event.numero, idClient: event.idClient, cvv: event.cvv, date: event.date, nom: event.nom);
          await databaseHelper.insertCardPayment(payment);
          emit (AjoutCardPaymentsSucces('Mode de paiement par carte ajouté avec succès !'));
        } catch (e) {
          emit (AjoutCardPaymentsError('Échec de l\'ajout du mode de paiement par carte'));
        }
      } else if (event is GetMobilePayments) {
        emit (PaymentLoading());
        try {
          final payments = await databaseHelper.getMobilePayments(event.idClient);
          emit (MobilePaymentsLoaded(payments));
        } catch (e) {
          emit (AjoutMobilePaymentsError('Échec du chargement des paiements mobiles'));
        }
      } else if (event is GetCardPayments) {
        emit (PaymentLoading());
        try {
          final payments = await databaseHelper.getCardPayments(event.idClient);
          emit (CardPaymentsLoaded(payments));
        } catch (e) {
          emit (AjoutCardPaymentsError('Échec du chargement des paiements par carte'));
        }
      } else if(event is ShuffleList){
        emit(PaymentLoading());
        try{
          /*final shuffledItems = List<Map<String, dynamic>>.from(paymentMethods)..shuffle(Random());*/
          final shuffledItems = await paymentMethods;
          //print("object    $shuffledItems");
          emit(RandomListShuffled(shuffledItems));
        }catch(e){
          emit(RandomListShuffledError("Erreur de chargement"));
        }
      }
    });
  }
}
