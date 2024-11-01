import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationInitial()) {
    on<NavigationEvent>((event, emit) {
      if(event is NavigateToHome){
        emit(HomeState());
      }else if(event is NavigateToSettings){
        emit(SettingsState());
      }else if(event is NavigateToPaiement){
        emit(PaiementState());
      } else if(event is NavigateToPrepaye){
        emit(PrepayeState());
      }
    });
  }
}
