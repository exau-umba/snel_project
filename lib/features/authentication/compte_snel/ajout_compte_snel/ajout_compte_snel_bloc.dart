import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snel_project/data/models/compte_snel.dart';

import '../../../../data/services/database_helper.dart';

part 'ajout_compte_snel_event.dart';
part 'ajout_compte_snel_state.dart';

class AjoutCompteSnelBloc extends Bloc<AjoutCompteSnelEvent, AjoutCompteSnelState> {
  final DatabaseHelper databaseHelper;
  AjoutCompteSnelBloc(this.databaseHelper) : super(AjoutCompteSnelInitial()) {
    on<AjoutCompteSnelEvent>((event, emit) async {
      if(event is AddAccountSnel){
        emit(AjoutCompteSnelLoading());
        try{
          final account = CompteSnel(label: event.label, idClient: event.clientId);
          await databaseHelper.insertAccount(account);
          await Future.delayed(Duration(seconds: 2));
          emit(AjoutCompteSnelSucces("Compte ajouté avec succes"));
          add(GetAccountSnel());
        }catch(e){
          emit(AjoutCompteSnelError("Echec d'ajout $e"));
        }
      } else if(event is GetAccountSnel){
        emit(AjoutCompteSnelLoading());
        try{
          final accounts = await databaseHelper.getAccounts();
          emit(AccountSnelLoaded(accounts));
          print("LIST COMPTE: $accounts");
        }catch(e){
          emit(AjoutCompteSnelError("Echec de chargement"));
        }
      }
    });
  }
}
